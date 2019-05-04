//
//  AppCoordinator.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 04/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class AppCoordinator {
    private weak var rootViewController: UINavigationController?
    private var shipCoordinator: ShipCoordinator?

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        guard let rootViewController = self.rootViewController else { return }
        shipCoordinator = ShipCoordinator(rootViewController: rootViewController)
        shipCoordinator?.start()
    }
}
