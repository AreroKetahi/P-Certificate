//
//  CertificateSigningRequest.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

public struct CertificateSigningRequest<PublicKey>: Sendable, Hashable
where PublicKey: PCertificatePublicKey {
    public var version: Version
    
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
    
    internal(set) public var `extension`: [CertificateElement]
    
    /// Create a new certificate signing request
    /// - Parameters:
    ///   - version: Certificate version
    ///   - subjectName: Subject name
    ///   - subjectID: Subject identifier
    ///   - subjectDomain: Subject domain
    ///   - name: Certificate name
    ///   - id: Certificate identifier
    ///   - domain: Certificate domain
    ///   - publicKey: Public key
    ///   - extension: Certificate usage extension
    public init(
        version: Version,
        subjectName: String,
        subjectID: UUID,
        subjectDomain: Domain,
        name: String,
        id: UUID,
        domain: Domain,
        publicKey: PublicKey,
        `extension`: [CertificateElement] = []
    ) {
        self.version = version
        self.subjectName = subjectName
        self.subjectID = subjectID
        self.subjectDomain = subjectDomain
        self.name = name
        self.id = id
        self.domain = domain
        self.publicKey = publicKey
        self.extension = `extension`
    }
}
