//
//  Notification.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// An extension to the `Notification` type
extension Notification {
    
    #if canImport(UIKit)
    /// The height of the keyboard from the notification's userInfo.
    public var keyboardHeight: CGFloat {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
    #endif
    
}
