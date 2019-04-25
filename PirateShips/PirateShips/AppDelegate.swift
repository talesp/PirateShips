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
    var webservice = Webservice()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let viewController = UIViewController()
        viewController.view.backgroundColor = .cyan
        rootViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        webservice.load(PirateData.resource) { result in
            switch result {
            case let .success(pirateData):
                debugPrint(pirateData)
            case let .failure(error):
                debugPrint(error)
            }
        }
        return true
    }

}

