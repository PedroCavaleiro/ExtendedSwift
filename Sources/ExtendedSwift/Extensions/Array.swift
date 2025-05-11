//
//  Array.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation

extension Array {
    
    /// Adds a new element to first position of the array
    /// This mutates the array does not return a copy
    ///
    /// - Parameter newElement: Element to add
    public mutating func prepend(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
    /// Gets a element based on a index safely, returns null if out of bounds instead of throwing a exception
    ///
    /// - Parameter index: Index of the element to fetch
    /// - Returns: The element as nullable, if nil the position does not exist in the array
    public subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// Chunks a array into parts
    ///
    /// - Parameter size: The size of the chunks
    /// - Returns: The chunked array (an array in the array chunks)
    public func chunked(into size:Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }

}
