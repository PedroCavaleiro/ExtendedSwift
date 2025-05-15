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
    callback: @escaping (Bool) -> Void
) {
    final class CallbackBox: @unchecked Sendable {
        let callback: (Bool) -> Void
        init(_ callback: @escaping (Bool) -> Void) {
            self.callback = callback
        }
    }

    let callbackBox = CallbackBox(callback)
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometricsOrCompanion, error: &error) {
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometricsOrCompanion,
            localizedReason: reason
        ) { success, _ in
            // This closure is @Sendable because it's defined by the system API
            // We're capturing CallbackBox, which we mark as @unchecked Sendable
            DispatchQueue.main.async {
                callbackBox.callback(success)
            }
        }
    } else {
        print(error?.localizedDescription ?? "Biometrics authentication not available")
        DispatchQueue.main.async {
            callbackBox.callback(false)
        }
    }
}

/// Gets wether the device has biometrics available
public func biometricsAvailable() -> Bool {
    let context = LAContext()
    var error: NSError?
    
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
}
