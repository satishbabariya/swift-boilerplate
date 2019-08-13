//
//  Application+Configrations.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

// swiftlint:disable nesting
extension Application {
    /// Application Configrations
    struct Configrations {
        /// Facebook Config
        struct Facebook {
            struct Permissions {
                static var profile = "public_profile"
                static var email = "email"
            }

            static var parameters = ["fields": "id,email,name"] // picture
        }
    }
}
