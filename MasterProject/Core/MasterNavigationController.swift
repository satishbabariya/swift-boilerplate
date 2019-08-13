//
//  MasterNavigationController.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

class MasterNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configure()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configure() {
//        For Navigation Font and Colors.
//        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Application.Colors.white,
//                                                  NSAttributedString.Key.font: Application.Fonts.Roboto.medium.of(size: 38.0)]
//        navigationBar.tintColor = Application.Colors.white
//        navigationBar.backgroundColor = Application.Colors.black
//        navigationBar.barTintColor = Application.Colors.black
        navigationBar.prefersLargeTitles = true
    }
}
