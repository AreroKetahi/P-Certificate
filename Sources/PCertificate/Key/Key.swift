//
//  Key.swift
//
//
//  Created by Akivili Collindort on 2024/6/18.
//

import Foundation
import Crypto
import _CryptoExtras

// MARK: - Definition

/// P-Key
///
/// View all about P-Key, see <doc:Standard-2-Key> for more detail.
public struct Key: Equatable {
    let version: Version
    let algorithm: String
    let keySize: Int
    let isSymmetry: Bool
    let transparency: Transparency
    
    let content: Data
    
    let digest: String
    let id: UUID
    
    /// Create new key.
    /// - Parameters:
    ///   - version: Key version
    ///   - algorithm: Algorithm idetifier that the key conforms to.
    ///   - keySize: Key size of the  key, 0 for not sure.
    ///   - isSymmetry: `true` if the key is for symmetrical encryption, otherwise `false`.
    ///   - transparency: Transparency of the **asymmetrical** algorithm.
    ///   - content: Content of the key.
    ///   - id: Key identifier.
    public init(
        version: Version,
        algorithm: String,
        keySize: Int,
        isSymmetry: Bool,
        transparency: Transparency,
        content: Data,
        id: UUID = .init()
    ) {
        self.version = version
        self.algorithm = algorithm
        self.keySize = keySize
        self.isSymmetry = isSymmetry
        self.transparency = transparency
        self.content = content
        self.id = id
        
        self.digest = SHA256.hash(data: content).withUnsafeBytes {
            Data($0)
        }.hexadecimalRepresentation
    }
}

// MARK: - Export key to original type
extension Key {
    /// Try to release key from key container.
    /// - Parameter to: Target key type.
    /// - Returns: Exported key.
    public func releaseKey<K>(to: K.Type) throws -> K where K: PEncryptionKey {
        try K(rawValue: self.content)
    }
}
