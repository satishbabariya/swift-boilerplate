//
//  Events.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

/// A Naïve Event Implementation
///
/// Example :
///
/// let event = Event<Void>()
/// event.addHandler { print("Hello") }
/// event.addHandler { print("World") }
/// event.raise()
///
/// let event = Event<(String, String)>()
/// event.addHandler { a, b in print("Hello \(a), \(b)") }
/// let data = ("Colin", "Eberhardt")
/// event.raise(data)
///
class Events<T> {
    typealias EventHandler = (T) -> Void
    var eventHandlers = [EventHandler]()

    /// Event Handler
    ///
    /// - Parameter handler: closure
    func addHandler(handler: @escaping EventHandler) {
//        eventHandlers.append(handler)
        eventHandlers = [handler]
    }

    /// Invoke the event
    ///
    /// - Parameter data: Any Object
    func raise(data: T) {
        for handler in eventHandlers {
            handler(data)
        }
    }

    /// Remove All Events
    func removeAll() {
        eventHandlers.removeAll()
    }

    deinit {
        eventHandlers.removeAll()
    }
}
