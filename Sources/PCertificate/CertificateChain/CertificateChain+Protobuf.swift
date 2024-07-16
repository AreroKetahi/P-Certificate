//
//  CertificateChain+Protobuf.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - Protobuf Intergration
extension CertificateChain {
    /// Serialize certificate chain to binary format.
    /// - Returns: Binary certificate chain.
    public func serialize() throws -> Data {
        try self.mapped.serializedData()
    }
    
    /// Restore certificate chain from binary format.
    /// - Parameter data: Binary serialized chain.
    public init(serialized data: Data) throws {
        let proto = try PBCertificateChain(serializedBytes: data)
        let certificates = proto.chain.map { certificate in
            Certificate<PublicKey>(with: certificate)
        }
        self = try .init(certificates)
    }
}

// !!!: Private Property
extension CertificateChain {
    var mapped: PBCertificateChain {
        var chain = PBCertificateChain()
        for certificate in self.certificates {
            chain.chain.append(certificate.mapped)
        }
        return chain
    }
}
