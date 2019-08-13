//
//  ReachabilityService.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import Reachability

/// Reachability Service
final class ReachabilityService {
    // MARK: - Attributes

    /// Singleton Instance of ReachabilityService
    static let shared = ReachabilityService()
    fileprivate var reachability: Reachability?

    /// Is Internet Connect Avaiable
    static var isConnected: Bool {
        if shared.reachability != nil {
            shared.reachability = Reachability()
        }

        return shared.reachability?.connection != .none
    }

    // MARK: - Initilizations

    deinit {
        reachability?.stopNotifier()
    }

    // MARK: - Methods

    /// Begin observing Reachability Connection
    func start() {
        reachability = Reachability()

        reachability?.whenReachable = { _ in
            // Do Your Thing Here
        }

        reachability?.whenUnreachable = { _ in
            MessageManager.bottomMessage(message: "No internet connection.", type: .warning)
        }

        do {
            try reachability?.startNotifier()
        } catch {
            Log.error(error.localizedDescription)
        }
    }
}
