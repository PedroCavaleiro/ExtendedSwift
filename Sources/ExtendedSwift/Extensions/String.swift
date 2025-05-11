//
//  String.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import Foundation
import CommonCrypto
#if canImport(UIKit)
import UIKit
#endif

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension String {
    
    /// Checks if the email address is valid
    ///
    /// - Returns: A boolean indicating whether is valid or not
    public func isValidEmailAddress() -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0
            {
                returnValue = false
            }

        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }

        return  returnValue
    }

    #if canImport(UIKit)
    /// If the string is a BASE64 encoded image we get a UIImage?
    /// If it failes to parse the image it will return nil
    ///
    /// - Returns: The UIImage representing the BASE64 encoded image if failed to parse it returns nil
    public var toUIImage: UIImage? {
        guard let buf = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: buf)
    }
    #endif

    /// Trims whitespaces and newlines
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Returns the SHA256 hash of the current string
    /// *Note: It uses the Security.sha256(_: String) function*
    ///
    /// - Returns: The hashed string as HEX
    public func sha256() -> String {
        return Security.sha256(self)
    }
    
    /// Generates a HMAC
    ///
    /// - Parameters:
    ///   - algorithm: The algorithm to use for the HMAC
    ///   - key: The key to use when generating the HMAC
    /// - Returns: The string containing the HMAc as HEX
    public func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        let digest = stringFromResult(result: result, length: digestLen)

        result.deallocate()

        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash).lowercased()
    }

    /// Localizes a string
    ///
    /// - Parameter comment: A comment for the localization, defaults to empty string
    /// - Returns: the localized string
    public func localized(_ comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}
