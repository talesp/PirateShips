//
//  ShipDetailViewControllerSpecs.swift
//  PirateShipsTests
//
//  Created by tales.andrade on 03/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import PirateShips

class ShipDetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ShipDetailViewController") {
            it("should properly setup view content") {
                let sut = ShipDetailViewController(nibName: nil, bundle: nil)
                sut.setup(title: "Title", price: 42, description: "Ship description", image: "", greeting: .yoho)
                _ = sut.view
                let window = UIWindow.init(frame: UIScreen.main.bounds)
                window.rootViewController = UINavigationController(rootViewController: sut)
                window.makeKeyAndVisible()
                expect(window) == snapshot()
            }
            
            it("should present correct greeting message") {
                let sut = ShipDetailViewController(nibName: nil, bundle: nil)
                sut.setup(title: "Title", price: 42, description: "Ship description", image: "", greeting: .yoho)
                _ = sut.view
                let window = UIWindow.init(frame: UIScreen.main.bounds)
                window.rootViewController = UINavigationController(rootViewController: sut)
                window.makeKeyAndVisible()
                sut.greetings(sender: UIBarButtonItem())
                expect(sut.presentedViewController) == snapshot()
            }
        }
    }
}
