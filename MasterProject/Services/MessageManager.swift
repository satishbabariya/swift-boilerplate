//
//  MessageManager.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import SwiftMessages

/// Swift Message Builder and Manager
final class MessageManager {
    static func bottomMessage(message: String, type: Theme, id: String? = nil) {
        show(message: message, position: SwiftMessages.PresentationStyle.bottom, type: type, id: id)
    }

    static func bottomMessage(title: String, message: String, type: Theme, id: String? = nil) {
        show(title: title, message: message, position: SwiftMessages.PresentationStyle.bottom, type: type, id: id)
    }

    static func topMessage(message: String, type: Theme, id: String? = nil) {
        show(message: message, position: SwiftMessages.PresentationStyle.top, type: type, id: id)
    }

    static func topCenter(message: String, type: Theme, id: String? = nil) {
        show(message: message, position: SwiftMessages.PresentationStyle.center, type: type, id: id)
    }

    static func show(message: String, position: SwiftMessages.PresentationStyle, type: Theme, id: String? = nil) {
        let messageView: MessageView = MessageView.viewFromNib(layout: .cardView)
        if let id = id {
            messageView.id = id
        }
        messageView.configureTheme(type)
        messageView.bodyLabel?.text = message
        messageView.button?.isHidden = true
        messageView.titleLabel?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = position
        config.duration = .seconds(seconds: 2.0)
        SwiftMessages.show(config: config, view: messageView)
    }

    static func show(title: String, message: String, position: SwiftMessages.PresentationStyle, type: Theme, id: String? = nil) {
        let messageView: MessageView = MessageView.viewFromNib(layout: .cardView)
        if let id = id {
            messageView.id = id
        }
        messageView.configureTheme(type)
        messageView.bodyLabel?.text = message
        messageView.titleLabel?.text = title
        messageView.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = position
        config.duration = .seconds(seconds: 2.0)
        SwiftMessages.show(config: config, view: messageView)
    }

    static func show(message: String, type: Theme, duration: Double = 2.0) {
        let messageView: MessageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureTheme(type)
        messageView.bodyLabel?.text = message
        messageView.button?.isHidden = true
        messageView.titleLabel?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: duration)
        SwiftMessages.show(config: config, view: messageView)
    }
}
