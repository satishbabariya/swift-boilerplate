//
//  Dictionary+Extensions.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

extension Dictionary {
    /// Dictionary to JSON String
    ///
    /// - Returns: jsonstring
    public func JSONString() -> String {
        var jsonString: NSString = ""

        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        } catch let error as NSError {
            Log.error(error.localizedDescription)
        }

        return jsonString as String
    }
}

extension NSDictionary {
    /// Get JSON formatted String
    ///
    /// - Returns: string
    public func JSONString() -> String {
        var jsonString: NSString = ""

        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        } catch let error as NSError {
            Log.error(error.localizedDescription)
        }

        return jsonString as String
    }
}

extension NSArray {
    /// Get JSON formatted String
    ///
    /// - Returns: string
    public func JSONString() -> String {
        var jsonString: NSString = ""

        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        } catch let error as NSError {
            Log.error(error.localizedDescription)
        }

        return jsonString as String
    }
}
