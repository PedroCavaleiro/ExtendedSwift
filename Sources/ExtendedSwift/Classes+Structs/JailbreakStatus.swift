//
//  JailbreakStatus.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

#if canImport(UIKit)

import UIKit

/// A class that provides a shared instance to check if the device is jailbroken.
@MainActor
public class JailbreakStatus {

    static let shared = JailbreakStatus()

    private(set) public var isJailbroken: Bool = false
    
    /// Checks the jailbreak status of the device and updates the `isJailbroken` property.
    /// - Note: If the app is running on a macOS `isJailbroken` will always be false
    public func checkJailbreakStatus() {
        #if os(macOS)
            isJailbroken = false
        #else
            let isRunningOniPadMac = ProcessInfo.processInfo.isiOSAppOnMac
            if isRunningOniPadMac {
                isJailbroken = false
            }
            isJailbroken = UIDevice.current.isJailBroken || UIDevice.current.isFridaDetected
        #endif
    }
}

#endif
