//
//  Haptics.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


#if canImport(UIKit)

import UIKit

@MainActor
class Haptics {
    static let shared = Haptics()
    
    private init() { }

    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
    
}

#endif
