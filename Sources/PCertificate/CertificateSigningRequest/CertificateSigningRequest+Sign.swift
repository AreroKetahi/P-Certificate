//
//  CertificateSigningRequest+Sign.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/31.
//

import Foundation

extension CertificateSigningRequest {
    /// Sign the CSR.
    /// - Parameters:
    ///   - issuerName: Issuer name.
    ///   - issuerID: Issuer identifier.
    ///   - issuerDomain: Issuer domain.
    ///   - notValidBefore: Not valid before.
    ///   - notValidAfter: Not valid after
    ///   - privateKey: Private key that issuer use to sign.
    /// - Returns: Signed certificate.
    ///
    /// - Tip: After call this function, directly call ``Certificate/serialize()`` to export certificate to data bytes.
    public func sign(
        issuerName: String,
        issuerID: UUID,
        issuerDomain: Domain,
        notValidBefore: Date,
        notValidAfter: Date,
        using privateKey: PublicKey.PrivateKey
    ) throws -> Certificate<PublicKey> {
        var certificate = Certificate(
            version: self.version,
            issuerName: issuerName,
            issuerID: issuerID,
            issuerDomain: issuerDomain,
            subjectName: self.subjectName,
            subjectID: self.subjectID,
            subjectDomain: self.subjectDomain,
            name: self.name,
            id: self.id,
            domain: self.domain,
            publicKey: self.publicKey,
            notValidBefore: notValidBefore,
            notValidAfter: notValidAfter,
            extension: self.extension
        )

        try certificate.sign(with: privateKey)

        return certificate
    }

    /// Sign the CSR after customize original CSR.
    /// - Parameters:
    ///   - issuerName: Issuer name.
    ///   - issuerID: Issuer identifier.
    ///   - issuerDomain: Issuer domain.
    ///   - notValidBefore: Not valid before.
    ///   - notValidAfter: Not valid after
    ///   - privateKey: Private key that issuer use to sign.
    ///   - transaction: Transaction that want to apply on original CSR.
    /// - Returns: Signed certificate.
    ///
    /// - Tip: After call this function, directly call ``Certificate/serialize()`` to export certificate to data bytes.
    public func sign(
        issuerName: String,
        issuerID: UUID,
        issuerDomain: Domain,
        notValidBefore: Date,
        notValidAfter: Date,
        using privateKey: PublicKey.PrivateKey,
        transaction: (_ csr: inout CertificateSigningRequest) throws -> Void
    ) throws -> Certificate<PublicKey> {
        var csr = self
        try transaction(&csr)
        return try csr.sign(
            issuerName: issuerName,
            issuerID: issuerID,
            issuerDomain: issuerDomain,
            notValidBefore: notValidBefore,
            notValidAfter: notValidAfter,
            using: privateKey
        )
    }
}
