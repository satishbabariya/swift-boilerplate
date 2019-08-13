//
//  Launcher.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import IQKeyboardManager
import RequestLogger
import UIKit

final class Launcher {
    // MARK: - Attributes -

    static var window: UIWindow?
    static var navigationController: MasterNavigationController?

    // MARK: - Methods -

    /// Prepare all the things before Launch
    ///
    /// - Parameter options: A dictionary indicating the reason the app was launched (if any).
    /// The contents of this dictionary may be empty in situations where the user launched the app directly.
    /// For information about the possible keys in this dictionary and how to handle them, see Launch Options Keys.
    class func prepareToLaunch(with options: [UIApplication.LaunchOptionsKey: Any]?) {
        // Initilize Network Observer
        ReachabilityService.shared.start()

        // Setup Keybord Manager
        IQKeyboardManager.shared().isEnabled = true

        // Enable Fabric Before Deploy the App
        // Initilize Fabric
        // Fabric.with([Crashlytics.self])
        // Fabric.sharedSDK().debug = true

        // Setup Alamofire Request Logger
        if Application.Environment.isDebug() {
            RequestLogger(leval: .verbose).startLogging()
        }

        if Application.Environment.isDebug() {
            Log.logger = ApplicationLogger(.debug)
            Log.info("Application Logger is Enabled")
            Log.debug(options?.debugDescription ?? "")
        }
    }
}

// MARK: - UI

extension Launcher {
    /// Setup Launch UI
    ///
    /// - Parameter window: Appdelegate UIWindow
    class func launchUI(window: inout UIWindow?) {
        self.window = window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = Application.Colors.white
        isAuthorized()
    }

    /// Check Auth Status for Routing
    class func isAuthorized() {
        if Application.Auth.isUserLoggedin() {
            loadHomeUI()
        } else {
            loadAuthUI()
        }
    }

    /// Home Route
    fileprivate class func loadHomeUI() {
        navigationController = MasterNavigationController(rootViewController: HomeController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    /// Auth Route
    fileprivate class func loadAuthUI() {
        navigationController = MasterNavigationController(rootViewController: HomeController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    //        /// Observe Auth Status
    //        fileprivate class func observeAuthState() {
    //            Application.Auth.addStateDidChangeListener()
    //                .subscribe {
    //                    self.isAuthorized()
    //                }
    //                .disposed(by: self.disposeBag)
    //        }
}
