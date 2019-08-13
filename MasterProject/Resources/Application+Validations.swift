//
//  Application+Validations.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

extension Application {
    /// Application Validation Predicates
    struct Validation {
        static var url = NSPredicate(format: "SELF MATCHES %@", "((?:http|https)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+")
        static var email = NSPredicate(format: "SELF MATCHES %@", "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,})$") // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        static var password = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$&*]).{8,}")
        static var mobile = NSPredicate(format: "SELF MATCHES %@", "[235689][0-9]{6}([0-9]{3})?")
    }
}
