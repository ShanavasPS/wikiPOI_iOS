//
//  Network.swift
//  wikiPOI
//
//  Created by Shanavas Shaji on 17/01/20.
//  Copyright © 2020 shanavas. All rights reserved.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.digitransit.fi/routing/v1/routers/hsl/index/graphql")!)
}
