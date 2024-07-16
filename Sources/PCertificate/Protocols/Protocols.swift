//
//  Protocols.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - Top Protocol
public protocol PEncryptionKey: CustomStringConvertible, Sendable, Hashable {
    var rawValue: Data { get }
    
    init(rawValue: Data) throws
    
    static var algorithmIdentifier: String { get }
    
    var keySizeInBits: Int { get }
}


// MARK: - PCertificatePrivateKey
public protocol PCertificatePrivateKey: PEncryptionKey {
    associatedtype PublicKey: PCertificatePublicKey
    
    func sign(for digest: Data) throws -> Data
    
    func match(publicKey: PublicKey) -> Bool
}

// MARK: - PCertificatePublicKey
public protocol PCertificatePublicKey: PEncryptionKey {
    associatedtype PrivateKey: PCertificatePrivateKey
    
    func verify(_ signature: Data, for digest: Data) throws -> Bool
}
