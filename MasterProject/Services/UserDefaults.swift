//
//  UserDefaults.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

import SwiftyUserDefaults

// MARK: - Swifty User DefaultsKeys

extension DefaultsKeys {
    /// Authorization Bearer Token (Mostly JWT)
    static let authToken = DefaultsKey<String>("AuthorizationBearerToken")

    /// Authorizated Users Object String
    static let user = DefaultsKey<String>("AuthorizatedUsersInformations")
}
