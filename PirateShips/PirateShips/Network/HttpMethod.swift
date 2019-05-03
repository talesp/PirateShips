//
//  HttpMethod.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }

    func map<B>(function: (Body) -> B) -> HttpMethod<B> {
        switch self {
        case .get:
            return .get
        case let .post(body):
            return .post(function(body))
        }
    }
}
