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

extension Notification {
    
    #if canImport(UIKit)
    public var keyboardHeight: CGFloat {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
    #endif
    
}
