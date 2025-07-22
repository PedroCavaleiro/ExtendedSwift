//
//  NumberFormatter.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation

/// A collection of extensions for `NumberFormatter` to provide commonly used configurations.
extension NumberFormatter {

    /// A NumberFormatter configured for decimal numbers with a maximum of 3 fraction digits.
    public static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.numberStyle = .decimal
        return formatter
    }

}
