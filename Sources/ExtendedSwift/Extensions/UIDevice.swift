//
//  UIDevice.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation
import MachO
#if canImport(UIKit)
import UIKit

/// A collection of extensions for the UIDevice type
extension UIDevice {
    
    /// Gets wether the app is running in a sumulator or real device
    /// - Returns: A boolean indicating whether the app is running in a simulator
    public var isRunningOnSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    /// Checks if the device is jailbroken
    /// - Returns: A boolean indicating whether the device is jailbroken
    public var isJailBroken: Bool {
        get {
            if isRunningOnSimulator { return false }
            if JailBrokenHelper.hasCydiaInstalled() { return true }
            if JailBrokenHelper.isContainsSuspiciousApps() { return true }
            if JailBrokenHelper.isSuspiciousSystemPathsExists() { return true }
            return JailBrokenHelper.canEditSystemFiles()
        }
    }
    
    /// Checks if the device is running Frida
    /// - Returns: A boolean indicating whether Frida is detected
    public var isFridaDetected: Bool {
        get {
            if JailBrokenHelper.checkDYLD() { return true }
            if JailBrokenHelper.isFridaRunning() { return true }
            return false
        }
    }
}
#endif
