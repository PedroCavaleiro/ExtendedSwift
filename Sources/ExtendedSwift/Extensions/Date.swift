//
//  Date.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation

/// An extension to the Date class
extension Date {
    
    /// Gets the date as a RFC3339 String
    ///
    /// - Returns: The formatted string
    public func toRfc3339String() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter.string(from: self)
    }
    
    /// Gets the timestamp in seconds or miliseconds
    ///
    /// - Parameter inMiliseconds: Get the timestamp in seconds or miliseconds, defaults to true
    /// - Returns: The timestamp
    public func timestamp(inMiliseconds: Bool = true) -> Int64 {
        return inMiliseconds
            ? Int64(Date().timeIntervalSince1970 * 1000)
            : Int64(Date().timeIntervalSince1970)
    }
    
    /// Gets a string for "time since"
    /// These are not translated automatically but the following translations can be used
    ///
    /// - "just now"
    /// - "a minute ago" or "%lld minutes ago"
    /// - "a hour ago" or "%lld hours ago"
    /// - "yesterday"
    /// - "%lld days ago"
    /// - "last week"
    /// - "last month"
    /// - "%lld months ago"
    /// - "last year"
    /// - "%lld years ago"
    ///
    /// - Returns: The formatted string
    public func since() -> String {
        let seconds = abs(Date().timeIntervalSince1970 - self.timeIntervalSince1970)
        if seconds <= 120 {
            return "just now"
        }
        let minutes = Int(floor(seconds / 60))
        if minutes <= 60 {
            return minutes == 1 ? "a minute ago" : "\(minutes) minutes ago"
        }
        let hours = minutes / 60
        if hours <= 24 {
            return hours == 1 ? "a hour ago" : "\(hours) hours ago"
        }
        if hours <= 48 {
            return "yesterday"
        }
        let days = hours / 24
        if days <= 30 {
            return "\(days) days ago"
        }
        if days <= 14 {
            return "last week"
        }
        let months = days / 30
        if months == 1 {
            return "last month"
        }
        if months <= 12 {
            return "\(months) months ago"
        }
        let years = months / 12
        if years == 1 {
            return "last year"
        }
        return "\(years) years ago"
    }
    
    /// Checks if the `Date` instance is today
    /// - Returns: True if the instance is today otherwise false
    public func isToday() -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: Date())
        return components1.year == components2.year &&
               components1.month == components2.month &&
               components1.day == components2.day
    }
    
    /// Checks if the `Date` instance is yesterday
    /// - Returns: True if the instance is yesterday otherwise false
    public func isYesterday() -> Bool {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: yesterday)
        return components1.year == components2.year &&
               components1.month == components2.month &&
               components1.day == components2.day
    }
    
}
