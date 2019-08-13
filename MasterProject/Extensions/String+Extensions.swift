//
//  String+Extensions.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

extension String {
    /// String to JSON data.
    ///
    /// - Returns: JSON data or nil if an error occurs.
    func toAny() -> Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                Log.error(error.localizedDescription)
                return nil
            }
        }
        return nil
    }

    /// Get Query Parameters form String by Splitting String with & and =
    var queryParameters: [String: String] {
        return dictionaryBySplitting("&", keyValueSeparator: "=")
    }

    /// String To Dictionary
    ///
    /// - Parameters:
    ///   - elementSeparator: String between two Elements
    ///   - keyValueSeparator: Dictionary Key Value Seperator
    /// - Returns: Dictionary
    fileprivate func dictionaryBySplitting(_ elementSeparator: String, keyValueSeparator: String) -> [String: String] {
        var string = self

        if hasPrefix(elementSeparator) {
            string = String(dropFirst(1))
        }

        var parameters = [String: String]()

        let scanner = Scanner(string: string)

        var key: NSString?
        var value: NSString?

        while !scanner.isAtEnd {
            key = nil
            scanner.scanUpTo(keyValueSeparator, into: &key)
            scanner.scanString(keyValueSeparator, into: nil)

            value = nil
            scanner.scanUpTo(elementSeparator, into: &value)
            scanner.scanString(elementSeparator, into: nil)

            if let key = key as String? {
                if let value = value as String? {
                    if key.contains(elementSeparator) {
                        var keys = key.components(separatedBy: elementSeparator)
                        if let key = keys.popLast() {
                            parameters.updateValue(value, forKey: String(key))
                        }
                        for flag in keys {
                            parameters.updateValue("", forKey: flag)
                        }
                    } else {
                        parameters.updateValue(value, forKey: key)
                    }
                } else {
                    parameters.updateValue("", forKey: key)
                }
            }
        }

        return parameters
    }

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
