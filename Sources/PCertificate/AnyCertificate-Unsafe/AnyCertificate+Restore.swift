//
//  AnyCertificate+Unsafe.swift
//  
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

@_spi(UnsafeCertificate)
extension Certificate {
    /// Convert type-erased certificate to full information certificate.
    /// - Parameters:
    ///   - certificate: Type-erased certificate.
    ///   - type: Expected key type.
    public init(_ certificate: AnyCertificate, forKeyType type: PublicKey.Type) throws {
        let publicKey = try PublicKey(rawValue: certificate.publicKey)
        self = .init(
            version: certificate.version,
            issuerName: certificate.issuerName,
            issuerID: certificate.issuerID,
            issuerDomain: certificate.issuerDomain,
            subjectName: certificate.subjectName,
            subjectID: certificate.subjectID,
            subjectDomain: certificate.subjectDomain,
            name: certificate.name,
            id: certificate.id,
            domain: certificate.domain,
            publicKey: publicKey,
            notValidBefore: certificate.notValidBefore,
            notValidAfter: certificate.notValidAfter,
            extension: certificate.extension
        )
    }
}
