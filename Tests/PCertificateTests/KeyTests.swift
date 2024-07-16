//
//  KeyTests.swift
//
//
//  Created by Akivili Collindort on 2024/6/18.
//

import Testing
@testable import PCertificate
import Foundation
import Crypto
import _CryptoExtras

@Suite("Key Tests")
struct KeyTests {
    @Test("Create key package for 25519")
    func createKeyPackageFor25519() async throws {
        let key = Curve25519.Signing.PrivateKey()
        let pKey = Key(key)
        #expect(pKey.isSymmetry == false)
        #expect(pKey.keySize == 0)
        print(pKey)
    }
    
    @Test("Create Key Package For RSA")
    func createKeyPackageForRSA() async throws {
        let key = try _RSA.Signing.PrivateKey(keySize: .bits2048)
        let pKey = Key(key.publicKey)
        #expect(pKey.isSymmetry == false)
        #expect(pKey.keySize == 2048)
        print(pKey)
    }
    
    @Test("Create Symmetric Key")
    func createSymmetricKey() async throws {
        let key = SymmetricKey(size: .bits256)
        let pKey = Key(symmetric: key)
        #expect(pKey.isSymmetry == true)
        #expect(pKey.keySize == 256)
        print(pKey)
    }
    
    @Test("Serialize Key")
    func serializeKey() async throws {
        let key = Curve25519.Signing.PrivateKey()
        let pKey = Key(key)
        _ = try pKey.serialize()
    }
    
    @Test("Desrialized Key")
    func deserializeKey() async throws {
        let key = Data(
            base64Encoded: """
            CgUxLjAuMBIGWDI1NTE5KAEyIH4wxhxQvM+mk4avrZF0rw\
            o8jcRhD8+NcVv3oGdh/dv5OkAyYzhmOTBiNTFiMDI5NGI2\
            OWFjYjljMjcxNjU0OWYzZTk4NTM0MzBiMWI4ODUwNTg5YT\
            M0YmFjMDFhNjY3ZGI5QhArcOM378dK9IbknrQEDCtH
            """
        )!
        _ = try Key(serialized: key)
    }
    
    @Test("Release Key")
    func releaseKey() async throws {
        let key = Curve25519.Signing.PrivateKey()
        let pKey = Key(key)
        let releaseKey = try pKey.releaseKey(to: Curve25519.Signing.PrivateKey.self)
        #expect(key == releaseKey)
        
        #expect(throws: (any Error).self) {
            try pKey.releaseKey(to: _RSA.Signing.PrivateKey.self)
        }
        
    }
}

// Temporarily complies with the PEncryptionKey protocol
extension SymmetricKey: @unchecked @retroactive Sendable { }
extension SymmetricKey:@retroactive CustomStringConvertible {
    public var description: String {
        Self.algorithmIdentifier + String(self.keySizeInBits)
    }
}

extension SymmetricKey: @retroactive Hashable {}
extension SymmetricKey: @retroactive PEncryptionKey {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
    
    public var rawValue: Data {
        self.withUnsafeBytes { Data($0) }
    }
    
    public static let algorithmIdentifier = "AES"
    
    public var keySizeInBits: Int {
        self.rawValue.count * 8
    }
    
    public init(rawValue: Data) throws {
        self = .init(data: rawValue)
    }
}
