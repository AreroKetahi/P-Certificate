import Testing
import Foundation
@_spi(UnsafeCertificate) @testable import PCertificate
import Crypto
import _CryptoExtras

@Suite("P-Certificate Tests")
struct PCertificateTests {
    @Suite("X25519")
    struct X25519 {
        typealias TestCertificate = Certificate<Curve25519.Signing.PublicKey>
        
        var certificate: TestCertificate
        var privateKey: Curve25519.Signing.PrivateKey
        
        init() {
            let issuer = Target(
                name: "Issuer",
                id: UUID(uuidString: "12345678-9012-3456-7890-123456789012")!,
                domain: "dom.testing"
            )
            let subject = Target(
                name: "Subject",
                id: UUID(uuidString: "2FAE3FBE-9DEB-4D8D-B0EC-0887F277156D")!,
                domain: "dom.testing"
            )
            
            self.privateKey = .init()
            
            self.certificate = .init(
                version: .v1,
                issuerTarget: issuer,
                subjectTarget: subject,
                name: "Testing Certificate",
                id: UUID(uuidString: "B56C9B60-EEDC-414D-A191-E460AD697C46")!,
                domain: "dom.testing",
                publicKey: self.privateKey.publicKey,
                notValidBefore: .now,
                notValidAfter: (.now + ( 365 * 24 * 60))
            )
        }
        
        @Test("Serialized")
        func serialize() throws {
            let serialized = try certificate.serialize()
            #expect(serialized != nil)
        }
        
        @Test("Serialize ane Sign")
        func serializeAndSign() throws {
            let serialized = try certificate.serialize(with: privateKey)
            #expect(serialized != nil)
        }
        
        @Test("Deserialize And Verify")
        func deserializeAndVerify() throws {
            let serialized = try certificate.serialize(with: privateKey)
            let deserialized = try TestCertificate(serialized: serialized)
            #expect(try deserialized.verify(with: privateKey.publicKey))
        }
        
        @Test("Operate Certificate Extension")
        mutating func operateCertificateExtension() throws {
            // add
            certificate.addExtension(at: "x.testing.ca", value: #file)
            #expect(certificate.getExtension(at: "x.testing.ca") == #file)
            try certificate.addExtension(at: "x.testing.issueDate", value: Date.now)
            let queriedDate = try certificate.getExtension(at: "x.testing.issueDate", to: Date.self)
            #expect(queriedDate != nil)
            
            // delete
            certificate.deleteExtension(at: "x.testing.ca")
            #expect(certificate.getExtension(at: "x.testing.ca") == nil)
            certificate.deleteExtension(at: "x.testing.issueDate")
            #expect(certificate.getExtension(at: "x.testing.issueDate") == nil)
        }
        
        @Test("Sign")
        mutating func sign() throws {
            let privateKey = Curve25519.Signing.PrivateKey()
            try certificate.sign(with: privateKey)
            #expect(certificate.signature != nil)
            #expect(try certificate.verify(with: privateKey.publicKey))
            certificate.removeSign()
            #expect(certificate.signature == nil)
        }
    }
    
    @Suite("RSA")
    struct RSA {
        typealias TestCertificate = Certificate<_RSA.Signing.PublicKey>
        
        var certificate: TestCertificate
        var privateKey: _RSA.Signing.PrivateKey
        
        init() throws {
            let issuer = Target(
                name: "Issuer",
                id: UUID(uuidString: "12345678-9012-3456-7890-123456789012")!,
                domain: "dom.testing"
            )
            let subject = Target(
                name: "Subject",
                id: UUID(uuidString: "2FAE3FBE-9DEB-4D8D-B0EC-0887F277156D")!,
                domain: "dom.testing"
            )
            
            self.privateKey = try .init(keySize: .bits2048)
            
            self.certificate = .init(
                version: .v1,
                issuerTarget: issuer,
                subjectTarget: subject,
                name: "Testing Certificate",
                id: UUID(uuidString: "B56C9B60-EEDC-414D-A191-E460AD697C46")!,
                domain: "dom.testing",
                publicKey: self.privateKey.publicKey,
                notValidBefore: .now,
                notValidAfter: (.now + ( 365 * 24 * 60))
            )
        }
        
        func testSerialize() throws {
            let serialized = try certificate.serialize()
            #expect(serialized != nil)
        }
        
        func testSerializeAndSign() throws {
            let serialized = try certificate.serialize(with: privateKey)
            #expect(serialized != nil)
        }
        
        func testDeserializeAndVerify() throws {
            let serialized = try certificate.serialize(with: privateKey)
            let deserialized = try TestCertificate(serialized: serialized)
            #expect(try deserialized.verify())
        }
        
        mutating func testOperateCertificateExtension() throws {
            // add
            certificate.addExtension(at: "x.testing.ca", value: #file)
            #expect(certificate.getExtension(at: "x.testing.ca") == #file)
            try certificate.addExtension(at: "x.testing.issueDate", value: Date.now)
            let queriedDate = try certificate.getExtension(at: "x.testing.issueDate", to: Date.self)
            #expect(queriedDate != nil)
            
            // delete
            certificate.deleteExtension(at: "x.testing.ca")
            #expect(certificate.getExtension(at: "x.testing.ca") == nil)
            certificate.deleteExtension(at: "x.testing.issueDate")
            #expect(certificate.getExtension(at: "x.testing.issueDate") == nil)
        }
    }
}

struct AnyCertificateTests {
    func testDropTypeReferenceOfCertificate() throws {
        let privateKey: Curve25519.Signing.PrivateKey = .init()
        
        let issuer = Target(
            name: "Issuer",
            id: UUID(uuidString: "12345678-9012-3456-7890-123456789012")!,
            domain: "dom.testing"
        )
        let subject = Target(
            name: "Subject",
            id: UUID(uuidString: "2FAE3FBE-9DEB-4D8D-B0EC-0887F277156D")!,
            domain: "dom.testing"
        )
        
        let certificate = Certificate(
            version: .v1,
            issuerTarget: issuer,
            subjectTarget: subject,
            name: "Testing Certificate",
            id: UUID(uuidString: "B56C9B60-EEDC-414D-A191-E460AD697C46")!,
            domain: "dom.testing",
            publicKey: privateKey.publicKey,
            notValidBefore: .now,
            notValidAfter: (.now + ( 365 * 24 * 60))
        )
        
        let anyCert = AnyCertificate(certificate)
        
        try print(anyCert.serialize().base64EncodedString())
    }
    
    let certData = Data(base64Encoded: "CgUxLjAuMBIIMzIgYnl0ZXMaBklzc3VlciIQEjRWeJASNFZ4kBI0VniQEioLZG9tLnRlc3RpbmcyB1N1YmplY3Q6EC+uP76d602NsOwIh/J3FW1CC2RvbS50ZXN0aW5nShNUZXN0aW5nIENlcnRpZmljYXRlUhC1bJtg7txBTaGR5GCtaXxGWgtkb20udGVzdGluZ2Ig2PquAetVOLTN/XCirO5QbS2Xv2WUUp3MsyXNLI7Ld6VprtEyuEuc2UFxrtEyAE2e2UE=")
    
    func testRestoreTypeReference() throws {
        let serializedCert = try #require(self.certData)
        
        let anyCert = try AnyCertificate(serialized: serializedCert)
        
        _ = try Certificate(anyCert, forKeyType: Curve25519.Signing.PublicKey.self)
        
        #expect(throws: (any Error).self) {
            _ = try Certificate(anyCert, forKeyType: _RSA.Signing.PublicKey.self)
        }
    }
}
