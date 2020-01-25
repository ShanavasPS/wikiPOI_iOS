//
//  RouteSuggestionsCollectionViewCell.swift
//  wikiPOI
//
//  Created by Shamnad PS on 24/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import Foundation
import UIKit

class RouteSuggestionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var transitIcon: UIImageView!
    
    @IBOutlet weak var transitName: UILabel!
    
    func updateViewContents(leg: PlanQuery.Data.Plan.Itinerary.Leg) {
        transitIcon.image = UIImage(named: self.getImageForTheMode(leg));
        transitName.text = self.getDisplayTextForTheMode(leg);
    }
    
    private func getDisplayTextForTheMode(_ leg: PlanQuery.Data.Plan.Itinerary.Leg?) -> String {
        var displayText = "";
        if let mode = leg?.mode{
            switch mode {
            case .walk:
                displayText = String(duration: leg?.duration)
                break;
            default:
                if let tripName = leg?.trip?.routeShortName {
                    displayText = tripName;
                }
            }
        }
        return displayText;
    }
    
    private func getImageForTheMode(_ leg: PlanQuery.Data.Plan.Itinerary.Leg?) -> String {
        var transportImage:String = "";
        switch (leg?.mode) {
        case .bus:
            transportImage = "bus.png";
            break;
        case .tram:
            transportImage = "tram.png";
            break;
        case .subway:
            transportImage = "subway.png";
            break;
        case .rail:
            transportImage = "train.png"
            break;
        case .walk:
            transportImage = "walk.png"
            break;
        default:
            transportImage = ""
            break;
        }
        return transportImage;
    }
}
