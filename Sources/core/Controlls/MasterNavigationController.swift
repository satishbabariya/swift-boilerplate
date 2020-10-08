//
//  AbstractNavigationController.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

/// Abstract Navigation Controller
class AbstractNavigationController: UINavigationController {
    var tintColor: UIColor {
        return .white
    }

    var backgroundColor: UIColor {
        return navigationBar.isDarkMode ? .black : .gray
    }

    var titleTextAttributes: [NSAttributedString.Key: Any] {
        return [:]
    }

    var largeTitleTextAttributes: [NSAttributedString.Key: Any] {
        return [:]
    }

    var prefersLargeTitles: Bool {
        return false
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configure()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Provide Configration for Navigatioin Controller Here
    func configure() {
        navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationBar.titleTextAttributes = titleTextAttributes
        navigationBar.largeTitleTextAttributes = largeTitleTextAttributes

        navigationBar.tintColor = tintColor
        navigationBar.backgroundColor = backgroundColor
        navigationBar.barTintColor = backgroundColor

        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = titleTextAttributes
            navigationBarAppearance.largeTitleTextAttributes = largeTitleTextAttributes
            navigationBarAppearance.backgroundColor = backgroundColor

            navigationBar.standardAppearance = navigationBarAppearance
            navigationBar.compactAppearance = navigationBarAppearance
            navigationBar.scrollEdgeAppearance = navigationBarAppearance
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configure()
    }
}
