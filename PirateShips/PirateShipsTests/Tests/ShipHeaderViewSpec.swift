//
//  ShipHeaderViewSpecs.swift
//  PirateShipsTests
//
//  Created by Tales Pinheiro De Andrade on 02/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import PirateShips

class ShipHeaderViewSpec: QuickSpec {
    override func spec() {
        describe("ShipHeaderViewSpecs") {
            it("should have a valid view without image") {
                let bounds: CGRect = CGRect(origin: .zero, size: CGSize(width: 300, height: 100))
                let sut = ShipHeaderView()
                sut.frame = bounds
                sut.setup(title: "Title", price: 42, imageURL: "")
                sut.setNeedsLayout()
                sut.layoutIfNeeded()
                
                expect(sut) == snapshot()
            }
        }
    }
}
