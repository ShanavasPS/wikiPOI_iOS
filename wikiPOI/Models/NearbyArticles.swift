//
//  NearbyArticles.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 14/01/20.
//  Copyright © 2020 Shanavas Shaji. All rights reserved.
//

import Foundation

struct queryResult: Decodable
{
    let query:Articles;
}

struct Articles: Decodable
{
    let geosearch: [Article];
}

struct Article: Decodable
{
    let pageid: Int;
    let ns: Int;
    let title: String;
    let lat: Double;
    let lon: Double;
    let dist: Double;
    let primary: String;
}

struct Location: Decodable
{
    let latitude: Double;
    let longitude: Double;
}
