//
//  PrivateKey+Implementation.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation
import Crypto
import _CryptoExtras

// MARK: - PCertificatePrivateKey: RSA
extension _RSA.Signing.PrivateKey: PCertificatePrivateKey {
    public typealias PublicKey = _RSA.Signing.PublicKey
    
    public func sign(for digest: Data) throws -> Data {
        try self.signature(for: digest).rawRepresentation
    }
    
    public var rawValue: Data {
        self.derRepresentation
    }
    
    public init(rawValue: Data) throws {
        self = try .init(derRepresentation: rawValue)
    }
    
    static public let algorithmIdentifier: String = "RSA"
    
    public func match(publicKey: _RSA.Signing.PublicKey) -> Bool {
        self.publicKey == publicKey
    }
}

extension _RSA.Signing.PrivateKey: @retroactive CustomStringConvertible {
    public var description: String {
        return Self.algorithmIdentifier + String(keySizeInBits)
    }
}

extension _RSA.Signing.PrivateKey: @retroactive Equatable {}
extension _RSA.Signing.PrivateKey: @retroactive Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}

// MARK: - PCertificatePrivateKey: Curve25519
extension Curve25519.Signing.PrivateKey: @unchecked @retroactive Sendable { }

extension Curve25519.Signing.PrivateKey: PCertificatePrivateKey {
    public typealias PublicKey = Curve25519.Signing.PublicKey
    
    public func sign(for digest: Data) throws -> Data {
        try self.signature(for: digest )
    }
    
    public var rawValue: Data {
        self.rawRepresentation
    }
    
    public init(rawValue: Data) throws {
        self = try .init(rawRepresentation: rawValue)
    }
    
    static public let algorithmIdentifier: String = "X25519"
    
    public var keySizeInBits: Int { 0 }
    
    public func match(publicKey: Curve25519.Signing.PublicKey) -> Bool {
        self.publicKey == publicKey
    }
}

extension Curve25519.Signing.PrivateKey: @retroactive CustomStringConvertible {
    public var description: String { Self.algorithmIdentifier }
}

extension Curve25519.Signing.PrivateKey: @retroactive Equatable {}
extension Curve25519.Signing.PrivateKey: @retroactive Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
