//
//  HTTPURLResponse.swift
//  PirateShipsTests
//
//  Created by tales.andrade on 03/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

@testable import PirateShips

extension HTTPURLResponse {
    convenience init?<A>(resource: Resource<A>, statusCode: HTTPStatusCode = .ok) {
        self.init(url: resource.url, statusCode: statusCode.rawValue, httpVersion: nil, headerFields: nil)
    }
}
