//
//  App.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

@available(iOS 14.0, *)
extension App {
    
    /// Gets the safeArea for the view
    /// This allows to be accessible from the App struct
    ///
    /// - Returns: UIEdgeInsets for the safe area
    public func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}

#endif
