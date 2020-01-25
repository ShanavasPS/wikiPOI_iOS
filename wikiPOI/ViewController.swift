//
//  ViewController.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 13/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation
import RxCoreLocation
import MapKit
import RxMKMapView
import Polyline

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var directionsView: UIView!
    
    @IBOutlet weak var routesTableView: UITableView!
    
    @IBOutlet weak var poiCollectionView: UICollectionView!
    
    @IBOutlet weak var routeInfoTableView: UITableView!
        
    @IBOutlet weak var directionsViewPOITitle: UILabel!
    
    @IBOutlet weak var directionsViewPOIDescription: UILabel!
    
    @IBOutlet weak var wikipediaButton: UIButton!
    
    @IBOutlet weak var getRoutesButton: UIButton!
    
    @IBOutlet weak var backToPOIButton: UIButton!
    
    @IBOutlet weak var backToRouteSuggestionButton: UIButton!
    
    @IBOutlet weak var directionsViewBottomConstrant: NSLayoutConstraint!
    
    @IBOutlet weak var routesViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var routesInfoViewBottomConstraint: NSLayoutConstraint!
    
    let manager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private var mapCenterLocation: CLLocation?
    
    let pois: PublishSubject<[PointOfInterest]> = PublishSubject()
    var annotations = [PointOfInterest]();
    
    let tripItineries: PublishSubject<[PlanQuery.Data.Plan.Itinerary]> = PublishSubject()
    
    var itineries = [PlanQuery.Data.Plan.Itinerary]();
    
    var poiImages: PublishSubject<[String]> = PublishSubject()
    
    var currentPOI: PointOfInterest = PointOfInterest(title: "", poiTitle: "", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), pageId: 0, dist: 0)
    
    var routeInstructions: PublishSubject<[String]> = PublishSubject()
    var instructions: [String] = [String]()
    
    var foundLocation = false;
    
    private var locationAlert: UIAlertController = {
        let alertController = UIAlertController(title: "Location Authorization", message: "wikiPOI needs location access to fetch the nearby articles. To change the location permission please update your Privacy setting.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settingAction = UIAlertAction(title: "Update Setting", style: .default, handler: { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        alertController.addAction(okAction)
        alertController.addAction(settingAction)
        
        return alertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeButtons()
        initializeLocationManager()
        initializeCollectionView()
        initializeRouteSuggestionsTableView()
        initializeRouteInfoTableView()
    }
    
    private func initializeButtons() {
        wikipediaButton.rx.tap
            .subscribe(onNext: {
                guard let url = URL(string: "https://en.wikipedia.org/?curid=\(self.currentPOI.pageId))") else { return }
                UIApplication.shared.open(url)
            }).disposed(by: disposeBag)
        
        getRoutesButton.rx.tap
            .subscribe(onNext: {
                self.fetchRouteSuggestions()
                self.showRoutesView(true);
            }).disposed(by: disposeBag)
        
        backToPOIButton.rx.tap
            .subscribe(onNext: {
                self.showRoutesView(false);
            }).disposed(by: disposeBag)
        
        backToRouteSuggestionButton.rx.tap
            .subscribe(onNext: {
                self.showRoutesInfoView(false);
            }).disposed(by: disposeBag)
    }
    
    private func initializeLocationManager()
    {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        mapView.showsUserLocation = true;
        
        manager.rx
            .didChangeAuthorization
            .subscribe(onNext: {_, status in
                switch status {
                case .denied:
                    DispatchQueue.main.async {
                        self.present(self.locationAlert, animated: true, completion: nil)
                    }
                case .notDetermined:
                    ()
                case .restricted:
                    ()
                case .authorizedAlways, .authorizedWhenInUse:
                    ()
                @unknown default:
                    ()
                }
            })
            .disposed(by: disposeBag)
        
        // Install a forwarding delegate so we can use Rx Delegate Proxy
        // alongside our regular imperative delegate
        mapView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        _ = pois.asObservable().bind(to:
            mapView.rx.annotations)
    }
    
    private func initializeCollectionView() {
        poiCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag);
        
        poiImages.asObserver().bind(to: poiCollectionView.rx.items) {
            (collectionView, row, element) -> UICollectionViewCell in
            let indexPath = IndexPath(row: row, section: 0)
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "poiImageCell", for: indexPath) as! POIImagesCollectionViewCell
            if let encodedUrlString = element.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: encodedUrlString) {
                    if let data = NSData(contentsOf: url as URL) {
                        cell.poiImageView.image = UIImage(data: data as Data);
                    }
                }
            }
            return cell;
        }.disposed(by: disposeBag)
    }
    
    private func initializeRouteSuggestionsTableView() {
        
        routesTableView.layoutIfNeeded();
        routesTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag);
        
        routesTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.rendeRouteOverlay(index: indexPath.row);
            }).disposed(by: disposeBag)
        
        self.tripItineries.asObservable().bind (to: routesTableView.rx.items){ (tableView, row, element) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell") as! RouteSuggestionsTableViewCell
            
            cell.updateTableContents(element: element)
            
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func initializeRouteInfoTableView() {
        
        routeInfoTableView.layoutIfNeeded();
        routeInfoTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag);
        
        self.routeInstructions.asObservable().bind (to: routeInfoTableView.rx.items){ (tableView, row, element) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "routeInfoCell") as! RouteInfoTableViewCell
            
            cell.title.text = element;
            
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func fetchNearbyPOIs()
    {
        guard let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&list=geosearch&gsradius=10000&gscoord=\(self.mapView.userLocation.coordinate.latitude)%7C\(self.mapView.userLocation.coordinate.longitude)&gslimit=50&format=json") else {
            return
        };
        
        let resource = Resource<queryResult>(url:url);
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { result in
                if let query = result.query {
                    DispatchQueue.main.async {
                        self.loadNearbyPOIsToMap(query.geosearch);
                    }
                }
            }).disposed(by: disposeBag);
    }
    
    private func loadNearbyPOIsToMap(_ articles: [Article]?)
    {
        guard let articles = articles
            else { return }
        annotations = loadPointsOfInterest(articles);
        self.pois.onNext(annotations);
        
        /// Reactive extensions for MKMapViewDelegate's
        /// various delegate methods
        mapView.rx.willStartLoadingMap
            .asDriver()
            .drive(onNext: {
            })
            .disposed(by: disposeBag)
        
        mapView.rx.didFinishLoadingMap
            .asDriver()
            .drive(onNext: {
            })
            .disposed(by: disposeBag)
        
        mapView.rx.regionDidChangeAnimated
            .subscribe(onNext: { _ in
            })
            .disposed(by: disposeBag)
        
        mapView.rx.region
            .subscribe(onNext: { region in
            })
            .disposed(by: disposeBag)
    }
    
    func fetchRouteSuggestions() {
        Network.shared.apollo.fetch(query: PlanQuery(fromlat: self.mapView.userLocation.coordinate.latitude, fromlon: self.mapView.userLocation.coordinate.longitude, tolat: currentPOI.coordinate.latitude, tolon:
            currentPOI.coordinate.longitude)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let pois = graphQLResult.data?.plan?.itineraries
                        else { return }
                    self.itineries = pois as! [PlanQuery.Data.Plan.Itinerary];
                    self.tripItineries.onNext(self.itineries);
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
        }
    }
    
    func rendeRouteOverlay(index: Int) {
        clearMapView()
        self.routeInstructions.onNext([])
        instructions.removeAll()
        
        var legInstructions = [[String]]();
        let legs = self.itineries[index].legs.compactMap { item -> PlanQuery.Data.Plan.Itinerary.Leg in
            if let leg = item {
                renderOverlay(leg);
                legInstructions.append(getRouteInstructions(leg))
            }
            return item!;
        }
        instructions = legInstructions.flatMap{$0};
        self.routeInstructions.onNext(instructions);
        getBoundingRectForOverlays(legs);
    }
    
    func getRouteInstructions(_ leg: PlanQuery.Data.Plan.Itinerary.Leg) -> [String]{
        var instructions: [String] = [String]()
        var tranportMode: String = ""
        let startTime = String(unixMilliSeconds: leg.startTime) + ": ";
        let endTime = String(unixMilliSeconds: leg.endTime) + ": ";
        
        if leg.mode == Mode.walk {
            instructions.append(startTime + "Walk " + String(duration: leg.duration))
        }
        if leg.mode == Mode.bus {
            tranportMode = startTime + "Take Bus ";
        }
        if leg.mode == Mode.subway {
            tranportMode = startTime + "Take Metro ";
        }
        
        if leg.mode == Mode.tram {
            tranportMode = startTime + "Take Tram "
        }
        
        if let tripName = leg.trip?.routeShortName {
            instructions.append(tranportMode + tripName);
        }
        
        if let origin = leg.from.name {
            instructions.append("from " + origin);
        }
        if let destination = leg.to.name {
            instructions.append(endTime + "reach " + destination);
        }
        return instructions;
    }
    
    //To show only the selected poi when it is selected
    private func removeUnSelectedAnnotations() {
        let filteredPoints = annotations.filter { poi in
            if (poi == currentPOI) {
                return true;
            }
            else {
                return false;
            }
        }
        self.pois.onNext(filteredPoints);
    }
    
    func renderOverlay(_ leg: PlanQuery.Data.Plan.Itinerary.Leg) {
        if let points = leg.legGeometry?.points {
            let polyline = Polyline(encodedPolyline:points)
            if let mkPolyline = polyline.mkPolyline {
                mkPolyline.title = leg.mode.map { $0.rawValue }
                self.mapView.addOverlay(mkPolyline, level: .aboveRoads)
                self.showRoutesInfoView(true);
                self.removeUnSelectedAnnotations();
            }
        }
    }
    
    //To center the map based on the overlay
    func getBoundingRectForOverlays(_ legs: [PlanQuery.Data.Plan.Itinerary.Leg]) {
        let coordArray = legs.map{ item -> [CLLocationCoordinate2D] in
            return [CLLocationCoordinate2D(latitude: item.from.lat, longitude: item.from.lon), CLLocationCoordinate2D(latitude: item.to.lat, longitude: item.to.lon)]
        }
        let coordinates = coordArray.flatMap{$0}
        let points = coordinates.map { MKMapPoint($0) }
        let rects = points.map { MKMapRect(origin: $0, size: MKMapSize(width: 0, height: 0)) }
        let fittingRect = rects.reduce(MKMapRect.null)  { $0.union($1) }
        
        mapView.setVisibleMapRect(fittingRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 315, right: 20), animated: true)
    }
    
    func loadPointsOfInterest(_ articles: [Article]) -> [PointOfInterest] {
        //Convert the Article model to an array of PointOfInterest
        let cities = articles.map { (article) -> PointOfInterest in
            return PointOfInterest(title: "", poiTitle: article.title ?? "", subtitle: article.primary ?? "", coordinate: CLLocationCoordinate2D(latitude: article.lat ?? 0.0, longitude: article.lon ?? 0.0), pageId: article.pageid ?? 0, dist: article.dist ?? 0.0);
        }
        return cities
    }
    
    private func populatePOIDetails(pageId: Int)
    {
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&prop=info|description|images&pageids=\(pageId))&format=json";
        
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        };
        
        guard let url = URL(string: encodedUrlString) else {
            return
        };
        
        let resource = Resource<detailedPOIResult>(url:url);
        URLRequest.load(resource: resource)
            .subscribe(onNext: { result in
                self.fetchImageUrls();
                if let query = result.query {
                    DispatchQueue.main.async {
                        self.displayDetailedPOIs(query);
                    }
                }
            }).disposed(by: disposeBag);
    }
    
    private func displayDetailedPOIs(_ pages: DataResponse)
    {
        let pageDetails = pages.users;
        directionsViewPOITitle.text = pageDetails.title;
        directionsViewPOIDescription.text = pageDetails.description;
        showDirectionsView(true);
    }
    
    private func fetchImageUrls() {
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&prop=imageinfo&format=json&iiprop=url&generator=images&pageids=\(currentPOI.pageId)";
        
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        };
        
        guard let url = URL(string: encodedUrlString) else {
            return
        };
        
        let resource = Resource<POIImageResult>(url:url);
        URLRequest.load(resource: resource)
            .subscribe(onNext: { result in
                self.displayImageUrls(result.query);
            }).disposed(by: disposeBag);
    }
    
    private func displayImageUrls(_ response: ImageDataResponse?) {
        if let images = response?.images {
            let imageInfo:[String] = images.compactMap { item -> String in
                return item.imageinfo![0].url!
            }
            //Show only the jpg images
            let filteredImages = imageInfo.filter { image in
                return image.contains(".jpg")
            }
            self.poiImages.onNext(filteredImages);
        }
    }
    
    private func centerMapViewToUserLocation() {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }
    
    private func clearMapView() {
        mapView.removeOverlays(mapView.overlays)
    }
    
    func MKMapRectForCoordinateRegion(_ region:MKCoordinateRegion) -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))
        
        let a = MKMapPoint(topLeft)
        let b = MKMapPoint(bottomRight)
        
        return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
    }
    
    func showDirectionsView(_ show: Bool)
    {
        UIView.animate(withDuration: 0.3) {
            self.directionsViewBottomConstrant.constant = show ? 0: -295
            self.view.layoutIfNeeded()
        }
    }
    
    func showRoutesView(_ show: Bool)
    {
        UIView.animate(withDuration: 0.3) {
            self.routesViewBottomConstraint.constant = show ? 0: -295
            self.view.layoutIfNeeded()
        }
    }
    
    func showRoutesInfoView(_ show: Bool)
    {
        UIView.animate(withDuration: 0.3) {
            self.routesInfoViewBottomConstraint.constant = show ? 0: -295
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - TableView Delegates
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == routeInfoTableView {
            return 40;
        }
        else {
            return 80.0;
        }
    }
}

// MARK: - MKMapView Delegates
extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if foundLocation == false {
            foundLocation = true;
            centerMapViewToUserLocation();
            fetchNearbyPOIs()
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach { $0.alpha = 0.0 }
        
        UIView.animate(withDuration: 0.4,
                       animations: {
                        views.forEach { $0.alpha = 1.0 }
        })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil;
        }
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        
        view.tintColor = .green
        view.canShowCallout = true
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let view = view as? MKPinAnnotationView {
            view.pinTintColor = UIColor.blue
        }
        
        if let annotation = view.annotation as? PointOfInterest
        {
            currentPOI = annotation;
            //Remove overlays if any
            clearMapView();
            //Hide the subviews if any
            showRoutesView(false);
            showRoutesInfoView(false);
            //Fetch the details of the selected POI
            populatePOIDetails(pageId: currentPOI.pageId);
            //Center the map based on the selected POI Coordinates
            let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            let rect:MKMapRect = MKMapRectForCoordinateRegion(region);
            mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 295, right: 20), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let view = view as? MKPinAnnotationView {
            view.pinTintColor = UIColor.red
        }
        showDirectionsView(false);
        showRoutesInfoView(false);
        //Remove the overlays now that the poi is deselected
        clearMapView()
        centerMapViewToUserLocation();
        //Bring back all the annotations now that the poi is deselected
        self.pois.onNext(annotations);
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        
        switch (overlay.title)
        {
        case "WALK":
            renderer.strokeColor = UIColor.green
            break;
        case "BUS":
            renderer.strokeColor = UIColor.blue
            break;
        default:
            renderer.strokeColor = UIColor.blue
            break;
        }
        
        return renderer
    }
}

// MARK: - Map Annotation and Helpers
class PointOfInterest: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let poiTitle: String?
    let subtitle: String?
    let pageId: Int;
    let dist: Double;
    
    init(title: String, poiTitle: String, subtitle: String, coordinate: CLLocationCoordinate2D, pageId: Int, dist:Double) {
        self.title = title
        self.poiTitle = poiTitle
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.pageId = pageId
        self.dist = dist;
    }
}

extension MKCoordinateRegion {
    func contains(poi: PointOfInterest) -> Bool {
        return abs(self.center.latitude - poi.coordinate.latitude) <= self.span.latitudeDelta / 2.0
            && abs(self.center.longitude - poi.coordinate.longitude) <= self.span.longitudeDelta / 2.0
    }
}
