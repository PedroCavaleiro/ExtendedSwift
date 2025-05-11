//
//  ScrollOffsetPreferenceKey.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

public struct ScrollOffsetPreferenceKey: @preconcurrency PreferenceKey {
    @MainActor public static var defaultValue: CGFloat = 0
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

