//
//  ResponseParser.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//
import Foundation

typealias PaginatedData = (data: [String: Any], pagination: [String: Any])

// MARK: - Parse Responce -

extension RESTClient {
    /// Parse Response JSON
    ///
    /// - Parameter data: JSON
    /// - Returns: Any
    func parse(data: Data) -> Any {
        var responce: Any = data
        let jsonDecoder = JSONDecoder()

        switch self {
//        case .login, .register:
//            if let dictData: [String: Any] = responce as? [String: Any] {
//                if let dictUser: [String: Any] = dictData["user"] as? [String: Any] {
//                    if let token: String = dictUser["token"] as? String {
//                        Application.Auth.saveToken(token)
//                    }
//
//                    Application.Auth.save(dictUser)
//                    responce = User()
//                }
//            }

        case .users:
            do {
                responce = try jsonDecoder.decode(Users.self, from: data)
            } catch {
                print(error)
                responce = []
            }
            
        default:
            break
        }

        return responce
    }
        
}
