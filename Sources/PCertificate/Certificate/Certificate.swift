//
//  Certificate.swift
//
//
//  Created by Akivili Collindort on 2024/5/24.
//

import Foundation
import Crypto
import _CryptoExtras

// MARK: - Definition
/// P-Certificate
///
/// - Note: To use type-erased certificate type, add `@_spi(UnsafeCertificate)` before the import declaration.
///
/// ## Topics
///
/// ### Create certificate with different algorithms
///
/// - ``init(version:issuerName:issuerID:issuerDomain:subjectName:subjectID:subjectDomain:name:id:domain:publicKey:notValidBefore:notValidAfter:extension:signature:)``
///
/// ### Create certificate with Target
///
/// - ``init(version:issuerTarget:subjectTarget:name:id:domain:publicKey:notValidBefore:notValidAfter:extension:signature:)``
///
/// ### Serialize and deserialize certificate
///
/// - ``serialize()``
/// - ``serialize(with:)``
/// - ``init(serialized:)``
///
/// ### Operate extension
///
/// - ``addExtension(at:value:)-s5tc``
/// - ``addExtension(at:value:)-9gaid``
/// - ``getExtension(at:)``
/// - ``getExtension(at:to:)``
/// - ``deleteExtension(at:)``
/// - ``deleteExtension(_:at:)``
///
/// ### Verify certificate
///
/// - ``verify()``
///
public struct Certificate<PublicKey>: Sendable, Hashable where PublicKey: PCertificatePublicKey {
    public var version: Version
    
    public var issuerName: String
    public var issuerID: UUID
    public var issuerDomain: Domain
    
    public var subjectName: String
    public var subjectID: UUID
    public var subjectDomain: Domain
    
    /// Certificate name
    public var name: String
    /// Certificate UUID
    public var id: UUID
    /// Certificate Domain
    public var domain: Domain
    
    public var publicKey: PublicKey
    
    public var notValidBefore: Date
    public var notValidAfter: Date
    
    internal(set) public var `extension`: [CertificateElement]
    
    public var signature: Data?

    /// Create new certificate.
    /// - Parameters:
    ///   - version: Certificate version
    ///   - issuerName: Issuer name
    ///   - issuerID: Issuer unique identifier
    ///   - issuerDomain: Issuer domain
    ///   - subjectName: Subject name
    ///   - subjectID: Subject uniqye identifier
    ///   - subjectDomain: Subject domain
    ///   - name: Certificate name
    ///   - id: Certificate unique identifier
    ///   - domain: Certificate domain
    ///   - publicKey: Public key that associate to subject's private key
    ///   - notValidBefore: Certificate valid date
    ///   - notValidAfter: Certificate expire date
    ///   - extension: Certificate extensions
    ///   - signature: Certificate Signature
    public init(
        version: Version,
        issuerName: String,
        issuerID: UUID,
        issuerDomain: Domain,
        subjectName: String,
        subjectID: UUID,
        subjectDomain: Domain,
        name: String,
        id: UUID,
        domain: Domain,
        publicKey: PublicKey,
        notValidBefore: Date,
        notValidAfter: Date,
        extension: [CertificateElement] = [],
        signature: Data? = nil
    ) {
        self.version = version
        self.issuerName = issuerName
        self.issuerID = issuerID
        self.issuerDomain = issuerDomain
        self.subjectName = subjectName
        self.subjectID = subjectID
        self.subjectDomain = subjectDomain
        self.name = name
        self.id = id
        self.domain = domain
        self.publicKey = publicKey
        self.notValidBefore = notValidBefore
        self.notValidAfter = notValidAfter
        self.extension = `extension`
        self.signature = signature
    }
}

// MARK: - Tool Support
extension Certificate {
    /// Certificate subject
    public var subject: Target {
        Target(name: self.subjectName, id: self.subjectID, domain: self.subjectDomain)
    }
    
    /// Certificate Issuer
    public var issuer: Target {
        Target(name: self.issuerName, id: self.issuerID, domain: self.issuerDomain)
    }
    
    public var fullCertificateDomain: String {
        "\(self.domain).\(self.name)"
    }
    
    public var fullIssuerDomain: String {
        "\(self.issuerDomain).\(self.issuerName)"
    }
    
    public var fullSubjectDomain: String {
        "\(self.subjectDomain).\(self.subjectName)"
    }
}
