//
//  Certificate+Verifying.swift
//  
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation
import Crypto

// MARK: - Verifying
extension Certificate {
    /// Verify certificate reliability by using provided public key.
    /// - Parameter publicKey: Public key that signature relavant to .
    /// - Returns: `true` is this certificate is reliable, `false` not.
    public func verify(with publicKey: PublicKey) throws -> Bool {
        if let signature {
            var signlessCert = self
            signlessCert.signature = nil
            let serializedRawCert = try signlessCert.serialize()
            let digest = SHA512.hash(data: serializedRawCert).withUnsafeBytes { Data($0) }
            return try publicKey.verify(signature, for: digest)
        } else {
            throw CertificateError.noSignatureError
        }
    }
    
    /// Verify certificate reliability. **For root certificate use only**.
    /// - Returns: `true` is this certificate is reliable, `false` not.
    public func verify() throws -> Bool {
        guard self.subject == self.issuer else {
            throw CertificateError.notRootCertificateError
        }
        return try verify(with: self.publicKey)
    }
}

// MARK: - Signing
extension Certificate {
    /// Sign certificate.
    /// - Parameter privateKey: Private key that use to sign.
    public mutating func sign(with privateKey: PublicKey.PrivateKey) throws {
        self.removeSign()
        let serializedCert = try self.serialize()
        let digest = SHA512.hash(data: serializedCert).withUnsafeBytes { Data($0) }
        self.signature = try privateKey.sign(for: digest)
    }
    
    /// Remove signature.
    public mutating func removeSign() {
        self.signature = nil
    }
}
