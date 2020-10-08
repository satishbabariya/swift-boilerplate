//
//  AbstractTabBarController.swift
//  Cloud Storage
//
//  Created by Satish Babariya on 20/11/19.
//  Copyright © 2019 Upsquare Solutions Private Limited. All rights reserved.
//

import UIKit

class AbstractTabBarController: UITabBarController {
    var tintColor: UIColor {
        return tabBar.tintColor
    }

    var backgroundColor: UIColor? {
        return tabBar.backgroundColor
    }

    var textAttributes: [NSAttributedString.Key: Any] {
        return [:]
    }

    var selectedTextAttributes: [NSAttributedString.Key: Any] {
        return [:]
    }

    var imageInsets: UIEdgeInsets {
        return tabBarItem.imageInsets
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        tabBar.tintColor = tintColor
        tabBar.barTintColor = backgroundColor
        tabBar.backgroundColor = backgroundColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configure()
    }
}

extension AbstractTabBarController {
    func tabBarItem(title: String, icon: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(named: icon), selectedImage: UIImage(named: icon))
        tabBarItem.setTitleTextAttributes(textAttributes, for: UIControl.State.normal)
        tabBarItem.setTitleTextAttributes(selectedTextAttributes, for: UIControl.State.selected)

        if tabBar.traitCollection.horizontalSizeClass == .compact {
            tabBarItem.imageInsets = imageInsets
        }

        return tabBarItem
    }
}
