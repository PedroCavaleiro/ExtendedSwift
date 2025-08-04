//
//  CryptoAlgorithm.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import CommonCrypto

/// A collection of cryptographic algorithms used for hashing and HMAC operations.
/// This enum provides access to various cryptographic algorithms, including MD5, SHA1, SHA224, SHA256, SHA384, and SHA512.
/// Each case provides the corresponding CCHmacAlgorithm.
public enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

    /// Returns the CCHmacAlgorithm associated with the crypto algorithm.
    /// - Returns: The CCHmacAlgorithm corresponding to the crypto algorithm.
    public var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    /// Returns the length of the digest for the crypto algorithm.
    /// - Returns: The length of the digest in bytes.
    public var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}