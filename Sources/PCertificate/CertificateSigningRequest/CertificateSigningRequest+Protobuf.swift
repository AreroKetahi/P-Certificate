//
//  CertificateSigningRequest+Protobuf.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/31.
//

import Foundation

extension CertificateSigningRequest {
    public func serialize() throws -> Data {
        try self.mapped.serializedData()
    }
    
    public init(serialized: Data) throws {
        let csr = try PBCertificateSigningRequest(serializedBytes: serialized)
        self = try .init(csr)
    }
    
    private init(_ csr: PBCertificateSigningRequest) throws {
        self.version = .init(stringLiteral: csr.version)
        self.subjectName = csr.subjectName
        self.subjectID = .init(csr.subjectID)!
        self.subjectDomain = .init(stringLiteral: csr.subjectDomain)
        self.name = csr.name
        self.id = .init(csr.id)!
        self.domain = .init(stringLiteral: csr.domain)
        self.publicKey = try .init(rawValue: csr.publicKey)
        self.extension = csr.extension.map {
            CertificateElement(key: .init(stringLiteral: $0.key), value: $0.value)
        }
    }
}

extension CertificateSigningRequest {
    private var mapped: PBCertificateSigningRequest {
        var csr = PBCertificateSigningRequest()
        
        csr.version = self.version.description
        csr.subjectName = self.name
        csr.subjectID = self.id.dataRepresentation
        csr.subjectDomain = self.subjectDomain.description
        csr.name = self.name
        csr.id = self.id.dataRepresentation
        csr.domain = self.domain.description
        csr.publicKey = self.publicKey.rawValue
        csr.extension = self.extension.map {
            var element = PBElement()
            element.key = $0.key.description
            element.value = $0.value
            return element
        }
        
        return csr
    }
}
