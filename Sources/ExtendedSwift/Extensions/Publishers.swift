//
//  Publishers.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation
import Combine

#if canImport(UIKit)
import UIKit
#endif

@available(macOS 10.15, *)
@available(iOS 13.0, *)
extension Publishers {
    
    #if canImport(UIKit)
    /// Allows the handling of the Keyboard appeared/disappeared notification
    public static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
    #endif
    
}
