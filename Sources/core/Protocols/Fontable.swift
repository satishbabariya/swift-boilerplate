//
//  Launchable.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

/// Font Protocol Confirming Size Function
protocol Fontable {
    /// Get UIFont for Given Size
    ///
    /// - Parameter size: Size in Float
    /// - Returns: UIFont Object
    func of(size: CGFloat) -> UIFont
}
