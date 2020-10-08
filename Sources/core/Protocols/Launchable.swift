//
//  Launchable.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import UIKit

protocol Launchable {
    static func prepareToLaunch(_ application: UIApplication, with options: [UIApplication.LaunchOptionsKey: Any]?)
}
