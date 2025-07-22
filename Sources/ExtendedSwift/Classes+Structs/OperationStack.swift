//
//  OperationStack.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

/// A type alias for a synchronous operation that takes no parameters and returns no value.
typealias Operation = () -> Void

/// A type alias for an asynchronous operation that takes no parameters and returns no value.
typealias OperationAsync = () async -> Void

/// Prevents multiple execution of the same task, ideal to use with .onAppear and .onDisappear when the tasks are meant to be run just once
@MainActor
class OperationStack {
    
    static let shared = OperationStack()
    
    /// A stack to keep track of currently running operations by their unique identifiers.
    var opStack: [String] = []
    
    /// Pushes a new operation onto the stack if it is not already present.
    /// This method executes the operation immediately and removes it from the stack once completed.
    /// - Parameters:
    ///   - id: A unique identifier for the operation, used to prevent duplicate executions.
    ///   - op: The operation to be executed.
    func push(id: String, op: @escaping Operation) {
        if self.opStack.contains(id) { return }
        self.opStack.append(id)
        Task {
            op()
            self.opStack.removeAll(where: { $0 == id })
        }
    }
    
    /// Pushes a new asynchronous operation onto the stack if it is not already present.
    /// This method executes the operation asynchronously and removes it from the stack once completed.
    /// - Parameters:
    ///   - id: A unique identifier for the operation, used to prevent duplicate executions.
    ///   - op: The asynchronous operation to be executed.
    func push(id: String, op: @escaping OperationAsync) {
        if self.opStack.contains(id) { return }
        self.opStack.append(id)
        Task {
            await op()
            self.opStack.removeAll(where: { $0 == id })
        }
    }
    
}
