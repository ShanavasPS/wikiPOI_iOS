//
//  String+Extenstion.swift
//  wikiPOI
//
//  Created by Shamnad PS on 21/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import Foundation

extension String {
    init(unixMilliSeconds: String?) {
        var formattedTime = "";
        if let unixMilliSeconds = unixMilliSeconds {
            if let startTimeInteger = Int64(unixMilliSeconds) {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                formattedTime = formatter.string(from: Date(milliseconds: startTimeInteger))
            }
        }
        self = formattedTime;
    }
    
    init(duration: String?) {
        var durationTime: String = "";
        if let durationStr = duration {
            if var duration = Double(durationStr) {
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
        }
        self = durationTime;
    }
    
    init(duration: Double?){
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
        self = durationTime;
    }
}
