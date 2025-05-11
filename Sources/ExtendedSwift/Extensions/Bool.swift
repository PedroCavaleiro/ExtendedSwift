//
//  Bool.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation

extension Bool {
    
    /// Initializes a boolean value from a string
    public init(_ stringValue: String) {
        switch stringValue {
            case "true":
                self.init(true)
            case "True":
                self.init(true)
            default:
                self.init(false)
        }
    }
    
    public init?(data:NSData) {
        guard data.length == 1 else { return nil }
        var value = false
        data.getBytes(&value, length: MemoryLayout<Bool>.size)
        self = value
    }
    
    public var data:NSData {
        var _self = self
        return NSData(bytes: &_self, length: MemoryLayout.size(ofValue: self))
    }
    
    /// The gets the boolean as a string value
    ///
    /// - Returns: The string representing the boolean
    public func toString() -> String {
        return (self ? "true" : "false")
    }
}
