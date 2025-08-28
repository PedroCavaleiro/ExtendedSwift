//
//  Untitled.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 28/08/2025.
//

import Foundation

#if canImport(UIKit)
import UIKit

/// A collection of extensions for the UIScreen type
public extension UIApplication {
    
    /// Gets the current window
    /// - Returns: The current UIWindow instance if available, otherwise nil
    static var currentWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first { $0.isKeyWindow }
    }
    
    /// Gets the app windows
    /// - Returns: The app UIWindows
    static var appWindows: [UIWindow] {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
    }
    
    /// Returns the size of the current window
    /// - Returns: The current window size as a `CGSize`
    /// - Note: If the current window is unavailable it will fallback to the current screen and if that it's unavailable it will return `.zero`
    static var currentWindowSize: CGSize {
        guard let window = currentWindow else {
            guard let screen = UIScreen.current else {
                return .zero
            }
            return screen.bounds.size
        }
        return window.bounds.size
    }
    
}
#endif
