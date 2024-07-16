//
//  Key+Initializers.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - Initializer for the key who conforms to PEncryptionKey
extension Key {
    /// Convenient create a asymmetric key container.
    /// - Parameters:
    ///   - key: Asymmetric key
    ///   - transparency: Transparency of the key.
    public init<K>(asymmetric key: K, transparency: Transparency) where K: PEncryptionKey {
        self = .init(
            version: .v1,
            algorithm: K.algorithmIdentifier,
            keySize: key.keySizeInBits,
            isSymmetry: false,
            transparency: transparency,
            content: key.rawValue
        )
    }
    
    /// Convenient create a symmetric key container.
    /// - Parameter key: Symmetric key.
    public init<K>(symmetric key: K) where K: PEncryptionKey {
        self = .init(
            version: .v1,
            algorithm: K.algorithmIdentifier,
            keySize: key.keySizeInBits,
            isSymmetry: true,
            transparency: .private,
            content: key.rawValue
        )
    }
}

// MARK: - Convenient Initializers

// Because of all the certificate algorithm should be always asymmetrical
// so fixed false for symmetry make sense.
extension Key {
    /// Create key container from P-Certificate private key.
    /// - Parameter key: Private key.
    public init<K>(_ key: K) where K: PCertificatePrivateKey {
        self = .init(asymmetric: key, transparency: .private)
    }
    
    /// Create key container from P-Certificate public key.
    /// - Parameter key: Public key.
    public init<K>(_ key: K) where K: PCertificatePublicKey {
        self = .init(asymmetric: key, transparency: .public)
    }
}
