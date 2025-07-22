//
//  UIImage.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation
#if canImport(UIKit)
import UIKit

/// A collection of extensions for the UIImage type
extension UIImage {
    
    /// Scales a `UIImage` to a size
    /// - Parameter size: The `CGSize` to scale the `UIImage` to
    /// - Returns: The scalled `UIImage`
    public func scaled(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
#endif
