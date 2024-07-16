//
//  AnyCertificate+Algorithm.swift
//  
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

extension AnyCertificate {
    /// Type-erased Certificate Algorithm
    public struct Algorithm: Sendable, Equatable, Hashable, CustomStringConvertible {
        var algorithm: String
        var keySizeInBit: Int?
        
        /// Create a new algorithm alias.
        ///
        /// The built-in algorithm's alias are shown below:
        ///
        /// |Algorithm Name|identifier|Has Key Size|
        /// |-|-|-|
        /// |RSA|`"RSA"`|Yes|
        /// |X25519|`"X25519"`|No|
        /// - Parameters:
        ///   - algorithm: Algorithm identifier string.
        ///   - keySizeInBit: The key size that this algorithm have, some alogrithm does not support key size, which pass `nil` in.
        public init(_ algorithm: String, keySizeInBit: Int? = nil) {
            self.algorithm = algorithm
            self.keySizeInBit = keySizeInBit
        }
        
        /// X25519 Algorithm
        public static let x25519 = Self("X25519")
        
        /// RSA Algorithm
        /// - Parameter keySizeInBit: RSA key size.
        /// - Returns: RSA algorithm alias.
        public static func rsa(_ keySizeInBit: Int) -> Self {
            return Self("RSA", keySizeInBit: keySizeInBit)
        }
        
        public var description: String {
            if let keySizeInBit {
                return algorithm + "." + String(keySizeInBit)
            } else {
                return algorithm
            }
        }
    }
}

extension AnyCertificate.Algorithm: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let splitted = value.split(separator: ".")
        if splitted.count == 1 {
            self.algorithm = .init(splitted[0])
        } else {
            self.algorithm = .init(splitted[0])
            self.keySizeInBit = .init(splitted[1])
        }
    }
}
