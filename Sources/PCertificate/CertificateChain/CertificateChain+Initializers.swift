//
//  CertificateChain+Initializers.swift
//  
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - Initializers
extension CertificateChain {
    /// Create a certificate chain container.
    /// - Parameter certificates: Certificates which have chain relation.
    public init(_ certificates: [Certificate<PublicKey>]) throws {
        self.certificates = try Self.sortCertificate(certificates)
    }
    
    /// Create a certificate chain container.
    /// - Parameter certificates: Certificates which have chain relation.
    public init(_ certificates: Certificate<PublicKey>...) throws {
        self = try Self(.init(certificates))
    }
}

// MARK: - Tool Support
// !!!: Internal
extension CertificateChain {
    static func sortCertificate(_ certificates: [Certificate<PublicKey>]) throws -> [Certificate<PublicKey>] {
        var certificates = Set<Certificate<PublicKey>>(certificates)
        var result = [Certificate<PublicKey>]()
        
        repeat {
            if result.isEmpty {
                guard let root = certificates.first(where: { $0.issuer == $0.subject }) else {
                    throw CertificateError.notRootCertificateError
                }
                result.append(root)
                certificates.remove(root)
            } else {
                guard let next = certificates.first(where: { $0.issuer == result.last!.subject }) else {
                    throw CertificateError.notValidCertificateChain
                }
                result.append(next)
                certificates.remove(next)
            }
        } while !certificates.isEmpty
        
        return result
    }
}
