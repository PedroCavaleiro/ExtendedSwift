//
//  Int64.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation

extension Int64 {
    
    /// Converts a timestamp to a Date
    /// - Parameters:
    ///   - miliseconds: Specifies if the timestamp is in miliseconds or not. Defaults to true
    /// - Returns: The date generated from the timestamp
    public func getDateFromTimestamp(miliseconds: Bool = true) -> Date {
        return miliseconds
            ? Date(timeIntervalSince1970: (TimeInterval(self) / 1000.0))
            : Date(timeIntervalSince1970: TimeInterval(self))
        
    }
    
}
