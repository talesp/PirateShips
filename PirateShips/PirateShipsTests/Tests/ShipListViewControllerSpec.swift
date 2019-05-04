//
//  ShipListViewControllerSpecs.swift
//  PirateShipsTests
//
//  Created by tales.andrade on 03/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation
import Nimble
import Nimble_Snapshots
import Quick

@testable import PirateShips

class ShipListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ShipListViewController") {
            it("should have a valid datasource") {
                let sut = ShipListViewController(nibName: nil, bundle: nil)
                let viewModel = ShipListViewModel(collectionView: sut.collectionView)
                viewModel.viewState = .content([
                    Ship(title: "Title 1", description: "Description 1", price: 42, image: "", greeting: .ahoy),
                    Ship(title: "Title 2", description: "Description 2", price: 42, image: "", greeting: .arr),
                    Ship(title: "Title 3", description: "Description 3", price: 42, image: "", greeting: .aye)
                ])

                expect(sut.collectionView.numberOfItems(inSection: 0)) == 3
            }
        }
    }
}
