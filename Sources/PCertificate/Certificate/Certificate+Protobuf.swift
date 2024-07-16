//
//  Certificate+Protobuf.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - Protobuf Conversion
// !!!: Internal Porting Layer, SLOULD NOT BE EXPOSE
extension Certificate {
    var mapped: PBCertificate {
        var pbCert = PBCertificate()
        pbCert.version = self.version.description
        pbCert.algorithm = self.publicKey.description
        pbCert.issuerName = self.issuerName
        pbCert.issuerID = self.issuerID.dataRepresentation
        pbCert.issuerDomain = self.issuerDomain()
        pbCert.subjectName = self.subjectName
        pbCert.subjectID = self.subjectID.dataRepresentation
        pbCert.subjectDomain = self.subjectDomain()
        pbCert.name = self.name
        pbCert.id = self.id.dataRepresentation
        pbCert.domain = self.domain()
        pbCert.publicKey = self.publicKey.rawValue
        pbCert.notValidBefore = self.notValidBefore.timeIntervalSince1970
        pbCert.notValidAfter = self.notValidAfter.timeIntervalSince1970
        pbCert.extension = self.extension.map { e in
            var element = PBElement()
            element.key = e.key.description
            element.value = e.value
            return element
        }
        
        switch self.signature {
            case .some(let signature): pbCert.signature = signature
            case .none: pbCert.clearSignature()
        }
        return pbCert
    }
    
    init(with pbCert: PBCertificate) {
        self.version = .init(stringLiteral: pbCert.version)
        self.issuerName = pbCert.issuerName
        self.issuerID = .init(pbCert.issuerID)!
        self.issuerDomain = .init(stringLiteral: pbCert.issuerDomain)
        self.subjectName = pbCert.subjectName
        self.subjectID = .init(pbCert.subjectID)!
        self.subjectDomain = .init(stringLiteral: pbCert.subjectDomain)
        self.name = pbCert.name
        self.id = .init(pbCert.id)!
        self.domain = .init(stringLiteral: pbCert.domain)
        self.publicKey = try! .init(rawValue: pbCert.publicKey)
        self.notValidBefore = .init(timeIntervalSince1970: pbCert.notValidBefore)
        self.notValidAfter = .init(timeIntervalSince1970: pbCert.notValidAfter)
        self.extension = pbCert.extension.map { element in
                .init(key: .init(stringLiteral: element.key), value: element.value)
        }
        
        if pbCert.hasSignature {
            self.signature = pbCert.signature
        } else {
            self.signature = nil
        }
    }
}
