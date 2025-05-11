//
//  UIScreen.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation
#if canImport(UIKit)
import UIKit

@available(iOS 13.0, *)
extension UIScreen {
    
    /// Gets the current screen
    public static var current: UIScreen? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.screen
    }
    
}
#endif
