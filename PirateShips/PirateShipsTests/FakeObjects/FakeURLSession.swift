//
//  FakeURLSession.swift
//  PirateShipsTests
//
//  Created by tales.andrade on 03/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

class FakeURLSession: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    override func dataTask(with _: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        return FakeURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
}

class FakeURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
