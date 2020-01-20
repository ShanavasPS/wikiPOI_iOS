//
//  Date+Extensions.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 19/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
