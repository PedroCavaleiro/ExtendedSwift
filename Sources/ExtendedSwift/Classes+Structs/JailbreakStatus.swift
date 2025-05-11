//
//  JailbreakStatus.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

#if canImport(UIKit)

import UIKit

@MainActor
public class JailbreakStatus {
    static let shared = JailbreakStatus()
    private(set) var isJailbroken: Bool = false
    
    public func checkJailbreakStatus() {
        isJailbroken = UIDevice.current.isJailBroken || UIDevice.current.isFridaDetected
    }
}

#endif
