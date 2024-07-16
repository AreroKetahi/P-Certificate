//
//  Certificate+Serializer.swift
//  
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation
import Crypto

// MARK: - Serialize & Deserialize
extension Certificate {
    /// Directly serialize certificate to binary format.
    ///
    /// - Important: To disturbute certificate, use ``serialize(with:)`` instead.
    ///
    /// - Returns: Serialized certificate
    public func serialize() throws -> Data {
        let mappedCert = self.mapped
        return try mappedCert.serializedData()
    }
    
    /// Create certificate from binary format
    /// - Parameter pbCert: Binary certificate
    public init(serialized pbCert: Data) throws {
        let serialzedCert = try PBCertificate(serializedBytes: pbCert)
        self = .init(with: serialzedCert)
    }
    
    /// Sign and serialize certificate to binary format.
    ///
    /// - Important: Call this function will not directly sign this certificate, to sign this certificate, use ``sign(with:)`` instead.
    ///
    /// - Parameter privateKey: Private key that use to sign this certificate.
    /// - Returns: Serialized final certificate.
    public func serialize(with privateKey: PublicKey.PrivateKey) throws -> Data {
        let serializedCert = try self.serialize()
        let digest = SHA512.hash(data: serializedCert).withUnsafeBytes { Data($0) }
        let signature = try privateKey.sign(for: digest)
        let signedCert = {
            var newCert = self
            newCert.signature = signature
            return newCert
        }()
        return try signedCert.serialize()
    }
}
