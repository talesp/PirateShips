//
//  JSONHelper.swift
//  PirateShipsTests
//
//  Created by tales.andrade on 03/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

class JSONHelper {
    static func loadJSON(filename: String) -> Data? {
        guard let path = Bundle(for: JSONHelper.self).path(forResource: filename, ofType: "json") else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
    }
}
