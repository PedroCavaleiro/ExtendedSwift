//
//  PlaceholderModifier.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import Foundation
import SwiftUI

/// A view modifier that conditionally displays a placeholder view when a certain condition is met.
/// - Parameter showPlaceholder: A boolean value that determines whether the placeholder should be shown.
/// - Parameter placeholder: A closure that returns the placeholder view to be displayed.
public struct PlaceholderModifier<Placeholder: View>: ViewModifier {
    public var showPlaceholder: Bool
    public var placeholder: () -> Placeholder

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceholder {
                placeholder()
            }
            content
                .foregroundColor(.primary)
        }
    }
}
