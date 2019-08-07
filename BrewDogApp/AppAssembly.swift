//
//  AppAssembly.swift
//  BrewDogApp
//
//  Created by Alexandre on 07/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class AppAssembly {
    private(set) lazy var window = UIWindow(frame: UIScreen.main.bounds)
    private(set) lazy var rootViewController = UINavigationController()
    private(set) lazy var coreAssembly = CoreAssembly(navigationController: rootViewController)

    func setupRootViewController() {
        let initialViewController = coreAssembly.initialAssembly.viewController()
        rootViewController.pushViewController(initialViewController, animated: false)
        window.rootViewController = rootViewController
    }
    
}
