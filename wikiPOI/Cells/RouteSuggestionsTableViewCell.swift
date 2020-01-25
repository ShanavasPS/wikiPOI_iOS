//
//  RouteSuggestionsTableViewCell.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 17/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RouteSuggestionsTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    @IBOutlet weak var routesCollectionView: UICollectionView!
    
    @IBOutlet weak var departureArrivalLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    var routes = PublishSubject<[PlanQuery.Data.Plan.Itinerary.Leg?]>()

    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    func registerCell() {
        self.routesCollectionView.delegate = self
        
        routes.asObservable().bind(to: routesCollectionView.rx.items) {
            (collectionView, row, element) -> UICollectionViewCell in
            let indexPath = IndexPath(row: row, section: 0)
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "routeCell", for: indexPath) as! RouteSuggestionsCollectionViewCell
            cell.updateViewContents(leg: element!);
            return cell;
        }.disposed(by: disposeBag)
    }
    
    func updateTableContents(element: PlanQuery.Data.Plan.Itinerary) {
        if let legs:[PlanQuery.Data.Plan.Itinerary.Leg] = element.legs as? [PlanQuery.Data.Plan.Itinerary.Leg] {
            self.routes.onNext(legs);
        }
        durationLabel.text = String(duration: element.duration)
        departureArrivalLabel.text = String(unixMilliSeconds: element.startTime) + " - " + String(unixMilliSeconds: element.endTime)
    }
}
