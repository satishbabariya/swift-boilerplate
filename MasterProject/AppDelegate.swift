//
//  AppDelegate.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setup All The Kits and Frameworks
        Launcher.prepareToLaunch(with: launchOptions)

        // Setup UI for Launch
        Launcher.launchUI(window: &window)

        return true
    }
}
