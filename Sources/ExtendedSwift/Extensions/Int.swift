//
//  Int.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation

/// An extension to the `Int` type
extension Int {
    /// Formats a time in seconds into *hh:mm:ss*
    /// - Returns: A string representing the time in the format *hh:mm:ss*.
    public func formatTimeFromSeconds() -> String {
        let totalSeconds = self / 1000
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let remainingSeconds = totalSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
    }
}
