//
//  AppDelegate.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var rootViewController: UINavigationController?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let rootViewController = UINavigationController()
        rootViewController.view.backgroundColor = .cyan
        self.rootViewController = rootViewController
        appCoordinator = AppCoordinator(rootViewController: rootViewController)
        appCoordinator?.start()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
