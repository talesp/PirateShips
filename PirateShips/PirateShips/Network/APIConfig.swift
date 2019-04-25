//
//  APIConfig.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

enum APIConfig {
    static let baseURLString = "https://assets.shpock.com/mobile/interview-test/"
    static let baseURL = URL(string: APIConfig.baseURLString) !! "Verify the address for base URL"
}
