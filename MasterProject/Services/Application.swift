//
//  Application.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyUserDefaults

// MARK: - Auth

final class Application {
    /// Authendication
    struct Auth {
        /// is currently id currently signed-in or not
        ///
        /// - Returns: Bool
        static func isUserLoggedin() -> Bool {
            //            return Application.keychain[DefaultsKeys.userInfo._key] != nil//
            return Defaults[.authToken] != ""
        }

        /// Signs out the current user.
        static func signOut() {
            Defaults.removeAll()
            Launcher.isAuthorized()
        }

        fileprivate static func authTokenKey() -> String {
            return DefaultsKeys.authToken._key
        }

        fileprivate static func currentUserKey() -> String {
            return DefaultsKeys.user._key
        }

        /// Get Current User's Auth Token
        ///
        /// - Returns: Auth Token
        static func bearerToken() -> String {
            return "Bearer \(Defaults[.authToken])"
        }

        /// Save Auth Token
        ///
        /// - Parameter token: Auth Token
        static func saveToken(_ token: String) {
            Defaults[.authToken] = token
        }

        /// Saves Users Information to User Defaults in JSON String
        ///
        /// - Parameter data: Information Dictionary
        static func save(_ data: [String: Any]) {
            Defaults[.user] = data.JSONString()
        }

        /// The currently signed-in user.
        ///
        /// - Returns: User object (or null).
//        static func currentUser() -> User? {
//            guard let data: [String: Any] = Defaults[.user].toAny() as? [String: Any] else {
//                return nil
//            }
//            return User(from: data)
//        }

        /// By using a listener, you ensure that the Auth object isn't in an intermediate state—such as initialization—when you get the current user.
        static func addStateDidChangeListener() -> Observable<String?> {
            return UserDefaults.standard.rx.observe(String.self, authTokenKey())
        }

        static func user() -> Observable<String?> {
            return UserDefaults.standard.rx.observe(String.self, currentUserKey())
        }
    }
}

// MARK: - Environment

extension Application {
    /// Application Environment
    struct Environment {
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

    struct Info {
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

        static func appURL() -> URL {
            return URL(string: "https://itunes.apple.com/app/id1234567890")!
        }
    }
}
