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
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var departureLabel: UILabel!
    
    var routes: PublishSubject<[PlanQuery.Data.Plan.Itinerary.Leg]> = PublishSubject()

    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    func registerCell() {
        self.routesCollectionView.delegate = self
        
        routes.asObserver().bind(to: routesCollectionView.rx.items) {
            (collectionView, row, element) -> UICollectionViewCell in
            let indexPath = IndexPath(row: row, section: 0)
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "routeCell", for: indexPath) as! RouteSuggestionsCollectionViewCell
            cell.updateViewContents(leg: element);
            return cell;
        }.disposed(by: disposeBag)
    }
    
    func updateTableContents(element: PlanQuery.Data.Plan.Itinerary?) {
        if let legs:[PlanQuery.Data.Plan.Itinerary.Leg] = element?.legs as? [PlanQuery.Data.Plan.Itinerary.Leg] {
            self.routes.onNext(legs);
        }
//        fifthLabel.text = String(duration: element.duration)
//
//        departureLabel.text = String(unixMilliSeconds: element.startTime) + " - " + String(unixMilliSeconds: element.endTime)
    }
}
