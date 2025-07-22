//
//  JailBrokenHelper.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import Foundation
import MachO
#if canImport(UIKit)
import UIKit

/// A helper class to detect if the device is jailbroken by checking for Cydia, suspicious apps, system paths, and dynamic libraries.
/// It also checks if Frida is running, which is a common tool used in jailbroken devices.
@available(iOS 13.0, *)
internal struct JailBrokenHelper {
    
    /// Checks if Cydia is installed
    /// - Returns: true if installed
    @MainActor public static func hasCydiaInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    /// Checks if there are suspicious apps installed
    /// - Returns: True if installed
    public static func isContainsSuspiciousApps() -> Bool {
        for path in suspiciousAppsPathToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    /// Checks if there are suspicious paths in the file system
    /// - Returns: True if existent
    public static func isSuspiciousSystemPathsExists() -> Bool {
        for path in suspiciousSystemPathsToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    /// Checks if it's possible to access system files (a non jailbroken device can not access these)
    /// - Returns: True if system files are editable
    public static func canEditSystemFiles() -> Bool {
        let jailBreakText = "Developer Insider"
        do {
            try jailBreakText.write(toFile: jailBreakText, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
    
    /// Add more paths here to check for jail break
    /// - Returns: An array of suspicious app paths
    public static var suspiciousAppsPathToCheck: [String] {
        return ["/Applications/Cydia.app",
                "/Applications/blackra1n.app",
                "/Applications/FakeCarrier.app",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/WinterBoard.app"
        ]
    }
    
    /// Add more paths here to check for jail break
    /// - Returns: An array of suspicious system paths
    public static var suspiciousSystemPathsToCheck: [String] {
        return ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/private/var/lib/apt",
                "/private/var/lib/apt/",
                "/private/var/lib/cydia",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/private/var/stash",
                "/private/var/tmp/cydia.log",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/usr/bin/sshd",
                "/usr/libexec/sftp-server",
                "/usr/sbin/sshd",
                "/etc/apt",
                "/bin/bash",
                "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
    }
    
    /// Checks if there are suspicious dynamic libraries in the system
    /// - Returns: True if existent
    public static func checkDYLD() -> Bool {
        let suspiciousLibraries = [
            "FridaGadget",
            "frida",
            "cynject",
            "libcycript"
        ]
        for libraryIndex in 0..<_dyld_image_count() {
            
            guard let loadedLibrary = String(validatingCString: _dyld_get_image_name(libraryIndex)) else { continue }
            for suspiciousLibrary in suspiciousLibraries {
                if loadedLibrary.lowercased().contains(suspiciousLibrary.lowercased()) {
                    return true
                }
            }
        }
        return false
    }
    
    /// Checks if Frida is running
    /// - Returns: True if running
    public static func isFridaRunning() -> Bool {
        func swapBytesIfNeeded(port: in_port_t) -> in_port_t {
            let littleEndian = Int(OSHostByteOrder()) == OSLittleEndian
            return littleEndian ? _OSSwapInt16(port) : port
        }
        
        var serverAddress = sockaddr_in()
        serverAddress.sin_family = sa_family_t(AF_INET)
        serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1")
        serverAddress.sin_port = swapBytesIfNeeded(port: in_port_t(27042))
        let sock = socket(AF_INET, SOCK_STREAM, 0)
        
        let result = withUnsafePointer(to: &serverAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                connect(sock, $0, socklen_t(MemoryLayout<sockaddr_in>.stride))
            }
        }
        
        if result != -1 {
            return true
        }
        return false
    }
}
#endif