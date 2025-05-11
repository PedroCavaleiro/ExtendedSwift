//
//  OperationStack.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

typealias Operation = () -> Void
typealias OperationAsync = () async -> Void

/// Prevents multiple execution of the same task, ideal to use with .onAppear and .onDisappear when the tasks are meant to be run just once
@MainActor
class OperationStack {
    
    static let shared = OperationStack()
    
    var opStack: [String] = []
    
    func push(id: String, op: @escaping Operation) {
        if self.opStack.contains(id) { return }
        self.opStack.append(id)
        Task {
            op()
            self.opStack.removeAll(where: { $0 == id })
        }
    }
    
    func push(id: String, op: @escaping OperationAsync) {
        if self.opStack.contains(id) { return }
        self.opStack.append(id)
        Task {
            await op()
            self.opStack.removeAll(where: { $0 == id })
        }
    }
    
}
