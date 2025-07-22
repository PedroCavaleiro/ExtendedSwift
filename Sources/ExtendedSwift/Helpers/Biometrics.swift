//
//  Biometrics.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation
import LocalAuthentication
import CryptoKit

/// Authenticates a user using Biometrics (Face ID or Touch ID)
/// - Parameters:
///  - reason: The reason for the authentication, defaults to "Authenticate to continue
///  - callback: The callback for the authentication, the callback gives a boolean indicating if authentication was successful or not
@available(macOS 15.0, *)
@available(iOS 18.0, *)
@preconcurrency
public func authenticateWithBiometrics(
    reason: String = "Authenticate to continue",
    callback: @Sendable @escaping (Bool) -> Void
) {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
            DispatchQueue.main.async {
                callback(success)
            }
        }
    } else {
        DispatchQueue.main.async {
            callback(false)
        }
    }
}

/// Gets wether the device has biometrics available
/// - Returns: A boolean indicating whether biometrics are available
public func biometricsAvailable() -> Bool {
    let context = LAContext()
    var error: NSError?
    
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
}
