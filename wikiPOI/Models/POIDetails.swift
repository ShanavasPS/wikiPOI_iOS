//
//  POIDetails.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 14/01/20.
//  Copyright © 2020 Shanavas Shaji. All rights reserved.
//

import Foundation
import MapKit

struct detailedPOIResult: Decodable
{
    let query:DataResponse;
}

struct pageImages: Decodable{
    let ns: Int;
    let title: String;
}

public struct PageIdModel: Decodable {
    let pageid: Int;
    let ns: Int;
    let title: String;
    let contentmodel: String?;
    let pagelanguage: String?;
    let pagelanguagehtmlcode: String?;
    let pagelanguagedir: String?;
    let touched: String?;
    let lastrevid: Int?;
    let length: Int?;
    let description: String?;
    let descriptionsource: String?;
    let images: [pageImages]?;
}

struct GenericCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
}

struct DataResponse: Decodable {
    var users: PageIdModel

    private enum CodingKeys: String, CodingKey {
        case pages
    }

    // You must decode the JSON manually
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let empty = PageIdModel(pageid: 0, ns: 0, title: "", contentmodel: "", pagelanguage: "", pagelanguagehtmlcode: "", pagelanguagedir: "", touched: "", lastrevid: 0, length: 0, description: "", descriptionsource: "", images: []);
        self.users = empty;
        let subContainer = try container.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .pages)
        for key in subContainer.allKeys {
            let user = try subContainer.decode(PageIdModel.self, forKey: key)
            self.users = user
        }
    }
}
