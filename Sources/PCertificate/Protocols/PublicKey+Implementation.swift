//
//  PublicKey+Implementation.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation
import Crypto
import _CryptoExtras

// MARK: - PCertificatePublicKey: RSA
extension _RSA.Signing.PublicKey: PCertificatePublicKey {
    public typealias PrivateKey = _RSA.Signing.PrivateKey
    
    public func verify(_ signature: Data, for digest: Data) throws -> Bool {
        self.isValidSignature(.init(rawRepresentation: signature), for: digest)
    }
    
    public var rawValue: Data {
        self.derRepresentation
    }
    
    public init(rawValue: Data) throws {
        self = try .init(derRepresentation: rawValue)
    }
    
    static public let algorithmIdentifier: String = "RSA"
}

extension _RSA.Signing.PublicKey: @retroactive CustomStringConvertible {
    public var description: String {
        return Self.algorithmIdentifier + "." + String(keySizeInBits)
    }
}

extension _RSA.Signing.PublicKey: @retroactive Equatable {}
extension _RSA.Signing.PublicKey: @retroactive Hashable {
    public static func == (lhs: _CryptoExtras._RSA.Signing.PublicKey, rhs: _CryptoExtras._RSA.Signing.PublicKey) -> Bool {
        lhs.derRepresentation == rhs.derRepresentation
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}

// MARK: - PCertificatePublicKey: Curve25519
extension Curve25519.Signing.PublicKey: @unchecked @retroactive Sendable { }

extension Curve25519.Signing.PublicKey: PCertificatePublicKey {
    public typealias PrivateKey = Curve25519.Signing.PrivateKey
    
    public func verify(_ signature: Data, for digest: Data) throws -> Bool {
        self.isValidSignature(signature, for: digest)
    }
    
    public var rawValue: Data {
        self.rawRepresentation
    }
    
    public init(rawValue: Data) throws {
        self = try .init(rawRepresentation: rawValue)
    }
    
    static public let algorithmIdentifier: String = "X25519"
    
    public var keySizeInBits: Int { 0 }
}

extension Curve25519.Signing.PublicKey: @retroactive CustomStringConvertible {
    public var description: String { Self.algorithmIdentifier }
}

extension Curve25519.Signing.PublicKey: @retroactive Equatable {}
extension Curve25519.Signing.PublicKey: @retroactive Hashable {
    public static func == (lhs: Curve25519.Signing.PublicKey, rhs: Curve25519.Signing.PublicKey) -> Bool {
        lhs.rawRepresentation == rhs.rawRepresentation
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
