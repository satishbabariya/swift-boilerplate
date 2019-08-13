//
//  Application+Fonts.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

/// Font Protocol Confirming Size Function
private protocol Fontable {
    /// Get UIFont for Given Size
    ///
    /// - Parameter size: Size in Float
    /// - Returns: UIFont Object
    func of(size: CGFloat) -> UIFont
}

extension Application {
    /// Application Fonts
    struct Fonts {
        /// Roboto Font https://fonts.google.com/specimen/Roboto
        ///
        /// - Regular: Roboto-Regular
        /// - Light: Roboto-Light
        /// - Thin: Roboto-Thin
        /// - Medium: Roboto-Medium
        /// - Bold: Roboto-Bold
        enum Roboto: String, Fontable {
            case regular = "Roboto-Regular"
            case light = "Roboto-Light"
            case thin = "Roboto-Thin"
            case medium = "Roboto-Medium"
            case bold = "Roboto-Bold"

            /// Get UIFont for Given Size
            ///
            /// - Parameter size: Size in Float
            /// - Returns: UIFont Object
            func of(size: CGFloat) -> UIFont {
                return UIFont(name: rawValue, size: size) ?? UIFont.boldSystemFont(ofSize: size)
            }
        }
    }
}
