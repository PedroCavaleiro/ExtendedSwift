//
//  PlaceholderModifier.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import Foundation
import SwiftUI

@available(iOS 13.0, *)
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
