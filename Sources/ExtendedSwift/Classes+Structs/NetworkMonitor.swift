//
//  NetworkMonitor.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 15/05/2025.
//

import Network
import SwiftUI

@available(iOS 18.0, *)

@MainActor
final class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        monitor.pathUpdateHandler = { path in
            let connected = path.status == .satisfied
            Task { @MainActor in
                self.isConnected = connected
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
