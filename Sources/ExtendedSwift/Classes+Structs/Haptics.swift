//
//  Haptics.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


#if canImport(UIKit)

import UIKit

/// A singleton class to manage haptic feedback in the app.
/// It provides methods to play impact and notification haptics.
/// Usage:
/// ```swift
/// Haptics.shared.play(.medium)
/// Haptics.shared.notify(.success)
/// ```
@MainActor
class Haptics {
    
    static let shared = Haptics()
    
    private init() { }

    /// Plays an impact haptic feedback with the specified style.
    /// - Parameter feedbackStyle: The style of the impact feedback to play.
    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    /// Plays a notification haptic feedback with the specified type.
    /// - Parameter feedbackType: The type of the notification feedback to play.
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
    
}

#endif
