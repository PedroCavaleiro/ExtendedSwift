//
//  Security.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import CryptoKit
import Foundation

/// A utility class for security-related operations
@available(iOS 13.0, *)
@available(macOS 10.15, *)
public class Security {
    
    /// Hashes a string using SHA256
    /// - Parameter input: The string to hash
    /// - Returns: The hashed data represented by a string in hexadecimal
    public static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    
}
