//
//  CertChainTests.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Testing
@_spi(UnsafeCertificate)
@testable import PCertificate
import Crypto
import Foundation

@Suite("Certificate Chain Tests")
struct CertChainTests {
    typealias Cert = Certificate<Curve25519.Signing.PublicKey>
    var certificates: [Cert] = []
    
    init() throws {
        var lastPrivateKey: Curve25519.Signing.PrivateKey = .init()
        repeat {
            if certificates.isEmpty {
                let target = Target(
                    name: String(UUID().uuidString.prefix(6)),
                    id: .init(),
                    domain: "dom.testing"
                )
                var cert = Cert(
                    version: .v1,
                    issuerTarget: target,
                    subjectTarget: target,
                    name: String(UUID().uuidString.prefix(6)),
                    id: .init(),
                    domain: "dom.testing",
                    publicKey: lastPrivateKey.publicKey,
                    notValidBefore: .now,
                    notValidAfter: (.now + 365 * 24 * 60 * 60)
                )
                try cert.sign(with: lastPrivateKey)
                certificates.append(cert)
            } else {
                let newPrivateKey = Curve25519.Signing.PrivateKey()
                let subject = Target(
                    name: String(UUID().uuidString.prefix(6)),
                    id: .init(),
                    domain: "dom.testing"
                )
                var cert = Cert(
                    version: .v1,
                    issuerTarget: certificates.last!.subject,
                    subjectTarget: subject,
                    name: String(UUID().uuidString.prefix(6)),
                    id: .init(),
                    domain: "dom.testing",
                    publicKey: newPrivateKey.publicKey,
                    notValidBefore: .now,
                    notValidAfter: (.now + 365 * 24 * 60 * 60)
                )
                try cert.sign(with: lastPrivateKey)
                certificates.append(cert)
                lastPrivateKey = newPrivateKey
            }
        } while certificates.count != 3
    }
    
    @Test("Create Certificate Chain")
    func createCertChain() throws {
        let chain = try CertificateChain(certificates)
        #expect(chain.rootCertificate == certificates.first)
    }
    
    @Test("Verify Certificate Chain")
    func verifyCertChain() throws {
        let chain = try CertificateChain(certificates)
        #expect(try chain.verify())
    }
}
