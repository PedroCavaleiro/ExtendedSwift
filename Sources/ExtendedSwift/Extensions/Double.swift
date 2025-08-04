//
//  Double.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 04/08/2025.
//

import Foundation

extension Double {
    
    /// Initializes a `Double` from a string, replacing commas with dots.
    /// Not specifying the parameter `value` will default to the constructor `init(_ value: String)` that will not replace commas with dots
    /// failing to parse the value in this situation.
    /// - Parameter value: The string to convert to a `Double`.
    /// - Throws: An error if the string cannot be converted to a `Double`.
    init(value: String) throws {
        if let doubleValue = Double(value.replacingOccurrences(of: ",", with: ".")) {
            self = doubleValue
        } else {
            throw NSError(domain: "InvalidDoubleError", code: 1, userInfo: [NSLocalizedDescriptionKey: "The string '\(value)' could not be converted to a Double."])
        }
    }
    
}
