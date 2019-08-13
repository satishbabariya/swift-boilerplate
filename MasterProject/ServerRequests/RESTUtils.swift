//
//  RESTUtils.swift
//  MasterProject
//
//  Created by Satish Babariya on 31/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import SwiftMessages

/// REST Event
///
/// - success: data
/// - error: error
enum RESTEvent<T> {
    case success(T)
    case error(Error)
}

/// REST Meta
struct RESTMeta {
    let message: String
    let type: Theme

    init(statusCode: Int) {
        switch statusCode {
        case 200 ..< 300:
            message = "Sucess"
            type = .success
        default:
            message = "TODO"
            type = .error
        }
    }

    init?(meta: Any?) {
        guard let dict: [String: String] = meta as? [String: String] else {
            return nil
        }

        if let message: String = dict["message"], let status: String = dict["status"] {
            self.message = message
            if status == "fail" {
                type = .error
            } else {
                type = .success
            }
        } else {
            return nil
        }
    }
}

/// REST Error
struct RESTError: Error {
    let message: String
    let type: Theme
    let statusCode: Int?

    init(message: String, type: Theme, statusCode: Int?) {
        self.message = message
        self.type = type
        self.statusCode = statusCode
    }

    init(message: String, type: Theme) {
        self.message = message
        self.type = type
        statusCode = nil
    }
}

struct MultiPartFile {
    var data: Data
    var name: String
    var fileName: String
    var mimeType: String

    init(image: UIImage, name: String) {
        data = image.jpegData(compressionQuality: 0.1) ?? Data()
        self.name = name
        fileName = name + ".jpg"
        mimeType = "image/jpeg"
    }

    init(image data: Data, name: String) {
        self.data = data
        self.name = name
        fileName = name + ".jpg"
        mimeType = "image/jpeg"
    }

    init(video data: Data, name: String) {
        self.data = data
        self.name = name
        fileName = name + ".mp4"
        mimeType = "video/mp4"
    }
}
