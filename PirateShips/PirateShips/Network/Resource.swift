//
//  Resource.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

/// A type reperesenting a REST resource
public struct Resource<T: Decodable> {
    let url: URL
    let method: HttpMethod<Data>
    let parse: (Data) throws -> T
}

extension Resource {
    init(url: URL,
         method: HttpMethod<Any> = .get,
         decoder: JSONDecoder = JSONDecoder(),
         encoder _: JSONEncoder = JSONEncoder()) {
        self.url = url
        self.method = method.map { json in
            do {
                return try JSONSerialization.data(withJSONObject: json, options: [])
            }
            catch {
                fatalError(error.localizedDescription)
            }
        }
        parse = { data in
            try decoder.decode(T.self, from: data)
        }
    }
}
