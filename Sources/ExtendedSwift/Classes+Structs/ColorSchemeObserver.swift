//
//  ColorSchemeObserver.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

@available(iOS 17.0, *)
@available(macOS 14.0, *)
public struct ColorSchemeObserver: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    public let onChange: (ColorScheme) -> Void
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                onChange(colorScheme)
            }
            .onChange(of: colorScheme) { onChange(colorScheme) }
    }
}
