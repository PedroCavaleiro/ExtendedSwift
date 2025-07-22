//
//  IndexInfo.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import SwiftUI

/// A structure that holds information about an indexed element, including its index, a unique identifier, and the element itself.
internal struct IndexInfo<Index, Element, ID: Hashable>: Hashable {
    let index: Index
    let id: KeyPath<Element, ID>
    let element: Element

    /// The unique identifier of the element, extracted using the specified key path.
    var elementID: ID {
        self.element[keyPath: self.id]
    }

    /// Compares two IndexInfo instances for equality based on their element IDs.
    /// - Parameters:
    ///   - lhs: The left-hand side IndexInfo instance.
    ///   - rhs: The right-hand side IndexInfo instance.
    /// - Returns: A Boolean value indicating whether the two instances are equal.
    /// This comparison is based solely on the element ID, ignoring the index and element.
    static func == (_ lhs: IndexInfo, _ rhs: IndexInfo) -> Bool {
        lhs.elementID == rhs.elementID
    }

    /// Hashes the essential components of this IndexInfo by hashing the element ID.
    func hash(into hasher: inout Hasher) {
        self.elementID.hash(into: &hasher)
    }
}