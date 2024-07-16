//
//  AnyCertificate.swift
//
//
//  Created by Akivili Collindort on 2024/6/17.
//

import Foundation

/// Type-erased Certificate
///
/// For convert a certificate to `AnyCertificate`, use ``init(_:)``.
///
///
///
/// - Important: For security purposes, typed certificates can only be serialized and deserialized and can't be sign. To sign a certificate, consider using ``Certificate/init(_:forKeyType:)`` to convert the certificate to typed certificate. **You must attach `@_spi(UnsafeCertificate)`** before
/// import decleration to enable unsafe features.
@_spi(UnsafeCertificate)
public struct AnyCertificate: Sendable, Hashable {
    internal(set) public var version: Version
    internal(set) public var algorithm: Algorithm
    
    internal(set) public var issuerName: String
    internal(set) public var issuerID: UUID
    internal(set) public var issuerDomain: Domain
    
    internal(set) public var subjectName: String
    internal(set) public var subjectID: UUID
    internal(set) public var subjectDomain: Domain
    
    internal(set) public var name: String
    internal(set) public var id: UUID
    internal(set) public var domain: Domain
    
    internal(set) public var publicKey: Data
    
    internal(set) public var notValidBefore: Date
    internal(set) public var notValidAfter: Date
    
    internal(set) public var `extension`: [CertificateElement]
    
    internal(set) public var signature: Data?
}

extension AnyCertificate {
    /// Drop a certificate's key type information and create a type-erased certificate.
    /// - Parameter certificate: Key typed certificate.
    public init<PublicKey>(_ certificate: Certificate<PublicKey>)
    where PublicKey: PCertificatePublicKey {
        self.version = certificate.version
        self.algorithm = .init(
            PublicKey.algorithmIdentifier, 
            keySizeInBit: certificate.publicKey.keySizeInBits == 0 ? nil : certificate.publicKey.keySizeInBits
        )
        
        self.issuerName = certificate.issuerName
        self.issuerID = certificate.issuerID
        self.issuerDomain = certificate.issuerDomain
        
        self.subjectName = certificate.subjectName
        self.subjectID = certificate.subjectID
        self.subjectDomain = certificate.subjectDomain
        
        self.name = certificate.name
        self.id = certificate.id
        self.domain = certificate.domain
        
        self.publicKey = certificate.publicKey.rawValue
        
        self.notValidBefore = certificate.notValidBefore
        self.notValidAfter = certificate.notValidAfter
        
        self.extension = certificate.extension
        
        self.signature = certificate.signature
    }
}
