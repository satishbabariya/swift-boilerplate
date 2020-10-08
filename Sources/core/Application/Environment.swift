//
//  Environment.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

// MARK: - Environment

/// Application Environment
extension Application.Environment {
    private static let production: Bool = {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }()

    /// Check if Current Application is in Production or not
    ///
    /// - Returns: True of False
    static func isProduction() -> Bool {
        return production
    }

    /// Check if Current Application is in Debug mode or not
    ///
    /// - Returns: True of False
    static func isDebug() -> Bool {
        return !production
    }

    /// Check if Current Application is in Simulator or not
    ///
    /// - Returns: True of False
    static func isSimulator() -> Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
}

// MARK: - Info

extension Application.Info {
    /// A dictionary, constructed from the bundle's Info.plist file, that contains information about the receiver.
    private static let infoDictionary: [String: Any]? = {
        Bundle.main.infoDictionary
    }()

    /// Bundle Short Version String
    ///
    /// - Returns: Version String
    static func shortVersion() -> String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    static func version() -> String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }

    static func bundleID() -> String? {
        return Bundle.main.bundleIdentifier
    }

    static func appURL(id: String) -> URL {
        return URL(string: "https://itunes.apple.com/app/\(id)")!
    }
}
