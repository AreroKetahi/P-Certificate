//
//  Certificate+Errors.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

enum CertificateError: Error {
    case noSignatureError
    case notRootCertificateError
    case noRootCertificateInChain
    case notValidCertificateChain
    case mappingError(any Sendable)
    case unmatchedDigest(from: String, to: String)
    case identifierNotMatched(identifier: String)
    case pemLikeStringDataCourrpted
    case invalidPEMLikeStringLength
}

extension CertificateError: CustomStringConvertible {
    var description: String {
        return switch self {
            case .noSignatureError: "Cann't file any signature in the certificate."
            case .notRootCertificateError: "This is certificate is not a correct root certificate."
            case .noRootCertificateInChain: "Can't find root certificate in key chain."
            case .notValidCertificateChain: "The certificates provided can't be chained."
            case .mappingError(let value): "Can't map \(value)."
            case .unmatchedDigest(from: let from, to: let to): "Can't verify origin digest \(to) be equals to \(from)"
            case .identifierNotMatched(identifier: let id): "Identifier of provided string (\(id)) is not matched."
            case .pemLikeStringDataCourrpted: "Can't restore data from PEM like string."
            case .invalidPEMLikeStringLength: "Can't get correct data length from PEM like string."
        }
    }
}
