//
//  CertificateChain.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

/// Certificate Chain Container
///
/// To begin with `CertificateChain`, you have to use serval certificates to create a 
/// key chain, those certificate should have relavant relationship.
///
/// ```swift
/// /*
/// let root = ...
/// let ca = ...
/// let consumer = ...
/// */
///
/// let chain = CertificateChain(root, ca, consumer)
/// ```
/// You can use ``init(_:)-9xqx9`` as same.
///
/// The order of the certificates is not important,
/// but they must be revalent.
///
public struct CertificateChain<PublicKey>: Sendable where PublicKey: PCertificatePublicKey {
    /// All the certificate which contains in this certificate chain.
    internal(set) public var certificates: [Certificate<PublicKey>]
    
    /// Root certificate of this chain.
    public var rootCertificate: Certificate<PublicKey> {
        certificates[0]
    }
    
    init(certificates: [Certificate<PublicKey>]) {
        self.certificates = certificates
    }
}

// MARK: - Tool
extension CertificateChain {
    /// Add new node to the certificate chain.
    /// - Parameter newValue: New certificate which is issued by the last certificate.
    public mutating func append(_ newValue: Certificate<PublicKey>) throws {
        guard certificates.last?.subject == newValue.issuer else {
            throw CertificateError.notValidCertificateChain
        }
        self.certificates.append(newValue)
    }
    
    /// Count of the certificates in the chain.
    public var count: Int {
        self.certificates.count
    }
}

// MARK: - Verifying
extension CertificateChain {
    /// Verify the certificate chain.
    /// - Returns: `true` for this certifcate chain is reliable, otherwise `false`.
    public func verify() throws -> Bool {
        let certificates = try Self.sortCertificate(self.certificates)
        
        for i in 0..<certificates.count {
            if i == 0 {
                guard try certificates[i].verify() else { return false }
            } else {
                guard try certificates[i].verify(with: certificates[i - 1].publicKey) else { return false }
            }
        }
        
        return true
    }
}
