//
//  Color.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

/// An extension to the SwiftUI Color
@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension Color {
    
    /// Creates a new SwiftUI color based of a HEX color
    ///
    /// - Parameter hex: The HEX color can contain the #
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff0000) >> 16) / 255
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255
            let b = Double(hexNumber & 0x0000ff) / 255
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(red: 0, green: 0, blue: 0) // Default to black if hex string is invalid
        }
    }
}
