//
//  POIImageInfo.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 19/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import Foundation

struct ImageInfo: Decodable
{
    let url: String?
    let descriptionurl: String?
    let descriptionshorturl: String?
}

struct ImageDetails: Decodable
{
    let ns: Int?
    let title: String?
    let missing: String?
    let known: String?
    let imagerepository: String?
    let imageinfo: [ImageInfo]?
}

struct POIImageResult: Decodable
{
    let query:ImageDataResponse;
}

struct ImageDataResponse: Decodable {
    var images: [ImageDetails]? = [ImageDetails]()

    private enum CodingKeys: String, CodingKey {
        case pages
    }

    // You must decode the JSON manually
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let subContainer = try container.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .pages)
        for key in subContainer.allKeys {
            let image = try subContainer.decode(ImageDetails.self, forKey: key)
            self.images?.append(image)
        }
    }
}
