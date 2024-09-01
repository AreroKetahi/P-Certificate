//
//  Certificate+CustomStringConvertible.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - Protocol: CustomStringConvertible
extension Certificate: CustomStringConvertible {
    public var description: String {
        """
        P-Certificate Version \(self.version.description)
        Algorithm: \(self.publicKey.description)
        
        Certificate Name:   \(self.name)
        Certificate ID:     \(self.id.uuidString)
        Certificate Domain: \(fullCertificateDomain)
        
        Issuer Name:   \(self.issuerName)
        Issuer ID:     \(self.issuerID.uuidString)
        Issuer Domain: \(fullIssuerDomain)
        
        Subject Name:   \(self.subjectName)
        Subject ID:     \(self.subjectID.uuidString)
        Subject Domain: \(fullSubjectDomain)
        
        Not valid before \(notValidBefore), not valid after \(notValidAfter)
        
        Certificate Extensions:
        \(self.extension.map({ element in
            "    \(element.key): \(element.value)"
        }).joined(separator: "\n"))
        
        Signature Status: \(self.signature == nil ? "No signature" : "Has signature")
        """
    }
}
