//
//  String+Extensions.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /// Check if string is Alphanumeric
    ///
    /// - Returns: true or false
    func isAlphanumeric() -> Bool {
        return rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }

    func isNumaric() -> Bool {
        return rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil && self != ""
    }

    /// Check if string is Alphanumeric
    ///
    /// - Parameter ignoreDiacritics: ignore diacritic (a sign, such as an accent or cedilla,
    /// which when written above or below a letter indicates a difference in pronunciation from the same letter when unmarked or differently marked.)
    /// - Returns: true or false
    func isAlphanumeric(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil && self != ""
        } else {
            return isAlphanumeric()
        }
    }
}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height

        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}
