//
//  Target.swift
//
//
//  Created by Akivili Collindort on 2024/6/16.
//

import Foundation
import CryptoKit
import _CryptoExtras

/// Subject target payload
public struct Target: Sendable, Hashable, Codable {
    var name: String
    var id: UUID
    var domain: Domain
    
    /// Create target
    /// - Parameters:
    ///   - name: Target name
    ///   - id: Target Identifier
    ///   - domain: Target domain
    init(name: String, id: UUID, domain: Domain) {
        self.name = name
        self.id = id
        self.domain = domain
    }
}

extension Certificate {
    /// Create certificate with payloads
    /// - Parameters:
    ///   - version: Certificate version
    ///   - issuerTarget: Issuer target
    ///   - subjectTarget: Subject target
    ///   - name: Certificate name
    ///   - id: Certificate identifier
    ///   - domain: Certificate domain
    ///   - publicKey: Certificate public key
    ///   - notValidBefore: Not valid before
    ///   - notValidAfter: Not valid after
    ///   - extension: Certificate extensions
    ///   - signature: Signature
    public init(
        version: Version,
        issuerTarget: Target,
        subjectTarget: Target,
        name: String,
        id: UUID,
        domain: Domain,
        publicKey: PublicKey,
        notValidBefore: Date,
        notValidAfter: Date,
        extension: [CertificateElement] = [],
        signature: Data? = nil
    ) {
        self = .init(
            version: version,
            issuerName: issuerTarget.name, issuerID: issuerTarget.id, issuerDomain: issuerTarget.domain,
            subjectName: subjectTarget.name, subjectID: subjectTarget.id, subjectDomain: subjectTarget.domain,
            name: name, id: id, domain: domain,
            publicKey: publicKey,
            notValidBefore: notValidBefore,
            notValidAfter: notValidAfter,
            extension: `extension`,
            signature: signature
        )
    }
}
