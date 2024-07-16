//
//  Key+Serializer.swift
//  
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation
import Crypto

// MARK: - Serialize & Deserialize
extension Key {
    private var mapped: PBKey {
        var pbKey = PBKey()
        
        pbKey.version = self.version.description
        pbKey.algorithm = self.algorithm
        pbKey.keySize = Int32(self.keySize)
        pbKey.symmetry = self.isSymmetry
        pbKey.transparency = self.transparency.mapped
        pbKey.content = self.content
        pbKey.digest = self.digest
        pbKey.id = self.id.dataRepresentation
        
        return pbKey
    }
    
    /// Serialize to `Data`
    /// - Returns: `Data` representation.
    public func serialize() throws -> Data {
        try self.mapped.serializedData()
    }
    
    /// Restore key from `Data` representation`.`
    /// - Parameter data: `Data` representation.
    public init(serialized data: Data) throws {
        let pbKey = try PBKey(serializedBytes: data)
        
        self.version = .init(stringLiteral: pbKey.version)
        self.algorithm = pbKey.algorithm
        self.keySize = Int(pbKey.keySize)
        self.isSymmetry = pbKey.symmetry
        self.transparency = try pbKey.transparency.mapping()
        self.content = pbKey.content
        self.digest = pbKey.digest
        self.id = .init(pbKey.id)!
        
        let hash = SHA256.hash(data: self.content).withUnsafeBytes {
            Data($0)
        }.hexadecimalRepresentation
        guard hash == pbKey.digest else {
            throw CertificateError.unmatchedDigest(from: hash, to: pbKey.digest)
        }
    }
}

// MARK: - Porting
extension Key {
    /// Transparency of key.
    public enum Transparency: String, CustomStringConvertible {
        case `public`, `private`
        
        var mapped: PBTransparency {
            switch self {
                case .public: return .public
                case .private: return .public
            }
        }
        
        public var description: String {
            return switch self {
                case .public: "Public"
                case .private: "Private"
            }
        }
    }
}

// MARK: - Protobuf Porting
// !!!: Private Property
extension PBTransparency {
    func mapping() throws -> Key.Transparency {
        switch self {
            case .public: return .public
            case .private: return .private
            default: throw CertificateError.mappingError(self)
        }
    }
}
