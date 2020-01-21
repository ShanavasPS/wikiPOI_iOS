//
//  RouteSuggestionsTableViewCell.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 17/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import Foundation
import UIKit

class RouteSuggestionsTableViewCell: UITableViewCell {
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
    
    func updateTableContents(element: PlanQuery.Data.Plan.Itinerary) {
        
        if element.legs.count > 0 {
            firstLabel.text = self.getDisplayTextForTheMode(element.legs[0]);
            firstImage.image = UIImage(named: self.getImageForTheMode(element.legs[0]));
            firstLabel.isHidden = false;
            firstImage.isHidden = false;
        }
        else {
            firstLabel.isHidden = true;
            firstImage.isHidden = true;
        }
        if element.legs.count > 1 {
            secondLabel.text = self.getDisplayTextForTheMode(element.legs[1]);
            secondImage.image = UIImage(named: self.getImageForTheMode(element.legs[1]));
            secondLabel.isHidden = false;
            secondImage.isHidden = false;
        }
        else {
            secondLabel.isHidden = true;
            secondImage.isHidden = true;
        }
        if element.legs.count > 2 {
            thirdLabel.text = self.getDisplayTextForTheMode(element.legs[2]);
            thirdImage.image = UIImage(named: self.getImageForTheMode(element.legs[2]));
            thirdLabel.isHidden = false;
            thirdImage.isHidden = false;
        }
        else {
            thirdLabel.isHidden = true;
            thirdImage.isHidden = true;
        }
        if element.legs.count > 3 {
            fourthLabel.text = self.getDisplayTextForTheMode(element.legs[3]);
            fourthImage.image = UIImage(named: self.getImageForTheMode(element.legs[3]));
            fourthLabel.isHidden = false;
            fourthImage.isHidden = false;
        }
        else {
            fourthLabel.isHidden = true;
            fourthImage.isHidden = true;
        }
        
        fifthLabel.text = String(duration: element.duration)

        departureLabel.text = String(unixMilliSeconds: element.startTime) + " - " + String(unixMilliSeconds: element.endTime)
    }
    
    private func getDisplayTextForTheMode(_ leg: PlanQuery.Data.Plan.Itinerary.Leg?) -> String {
        var displayText = "";
        if let mode = leg?.mode{
            switch mode {
            case .walk:
                displayText = self.getDurationInString(leg?.duration)
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
    
    func getDurationInString(_ duration: Double?) -> String {
        var durationTime: String = "";
        if var duration = duration {
            if duration > 3600 {
                durationTime.append("\(Int(duration/3600)) h ")
                duration = duration - Double((Int(duration/3600) * 60))
            }
            if duration > 60 {
                durationTime.append("\(Int(duration/60)) min ")
            }
            if duration <= 60 {
                durationTime.append("1 min ")
            }
        }
        return durationTime;
    }
}
