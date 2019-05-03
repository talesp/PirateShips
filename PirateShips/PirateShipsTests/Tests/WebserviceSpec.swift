//
//  WebserviceSpec.swift
//  PirateShipsTests
//
//  Created by tales.andrade on 03/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PirateShips

class WebserviceSpec: QuickSpec {
    override func spec() {
        describe("Webservice") {
            let session = FakeURLSession()
            let sut = Webservice(urlSession: session)

            it("should return a list of pirate ships") {
                let resource = PirateData.resource
                guard let data = JSONHelper.loadJSON(filename: "PirateShips") else { fail(); return }
                session.data = data
                session.response = HTTPURLResponse(resource: resource)

                guard let pirateData = try? JSONDecoder().decode(PirateData.self, from: data) else { fail(); return }
                _ = sut.load(resource) { result in
                    switch result {
                    case let .success(response):
                        expect(response) == pirateData
                    case .failure:
                        fail()
                    }
                }
            }
        }
    }
}
