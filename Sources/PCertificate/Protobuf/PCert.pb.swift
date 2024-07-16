// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: PCert.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
    struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
    typealias Version = _2
}

struct PBCertificate: @unchecked Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    var version: String = String()
    
    var algorithm: String = String()
    
    var issuerName: String = String()
    
    var issuerID: Data = Data()
    
    var issuerDomain: String = String()
    
    var subjectName: String = String()
    
    var subjectID: Data = Data()
    
    var subjectDomain: String = String()
    
    var name: String = String()
    
    var id: Data = Data()
    
    var domain: String = String()
    
    var publicKey: Data = Data()
    
    var notValidBefore: Double = 0
    
    var notValidAfter: Double = 0
    
    var `extension`: [PBElement] = []
    
    var signature: Data {
        get {return _signature ?? Data()}
        set {_signature = newValue}
    }
    /// Returns true if `signature` has been explicitly set.
    var hasSignature: Bool {return self._signature != nil}
    /// Clears the value of `signature`. Subsequent reads from it will return its default value.
    mutating func clearSignature() {self._signature = nil}
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init() {}
    
    fileprivate var _signature: Data? = nil
}

struct PBElement: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    var key: String = String()
    
    var value: String = String()
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension PBCertificate: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = "Certificate"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "version"),
        2: .same(proto: "algorithm"),
        3: .standard(proto: "issuer_name"),
        4: .standard(proto: "issuer_ID"),
        5: .standard(proto: "issuer_domain"),
        6: .standard(proto: "subject_name"),
        7: .standard(proto: "subject_ID"),
        8: .standard(proto: "subject_domain"),
        9: .same(proto: "name"),
        10: .same(proto: "id"),
        11: .same(proto: "domain"),
        12: .standard(proto: "public_key"),
        13: .standard(proto: "not_valid_before"),
        14: .standard(proto: "not_valid_after"),
        15: .same(proto: "extension"),
        16: .same(proto: "signature"),
    ]
    
    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
                case 1: try { try decoder.decodeSingularStringField(value: &self.version) }()
                case 2: try { try decoder.decodeSingularStringField(value: &self.algorithm) }()
                case 3: try { try decoder.decodeSingularStringField(value: &self.issuerName) }()
                case 4: try { try decoder.decodeSingularBytesField(value: &self.issuerID) }()
                case 5: try { try decoder.decodeSingularStringField(value: &self.issuerDomain) }()
                case 6: try { try decoder.decodeSingularStringField(value: &self.subjectName) }()
                case 7: try { try decoder.decodeSingularBytesField(value: &self.subjectID) }()
                case 8: try { try decoder.decodeSingularStringField(value: &self.subjectDomain) }()
                case 9: try { try decoder.decodeSingularStringField(value: &self.name) }()
                case 10: try { try decoder.decodeSingularBytesField(value: &self.id) }()
                case 11: try { try decoder.decodeSingularStringField(value: &self.domain) }()
                case 12: try { try decoder.decodeSingularBytesField(value: &self.publicKey) }()
                case 13: try { try decoder.decodeSingularDoubleField(value: &self.notValidBefore) }()
                case 14: try { try decoder.decodeSingularDoubleField(value: &self.notValidAfter) }()
                case 15: try { try decoder.decodeRepeatedMessageField(value: &self.`extension`) }()
                case 16: try { try decoder.decodeSingularBytesField(value: &self._signature) }()
                default: break
            }
        }
    }
    
    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every if/case branch local when no optimizations
        // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
        // https://github.com/apple/swift-protobuf/issues/1182
        if !self.version.isEmpty {
            try visitor.visitSingularStringField(value: self.version, fieldNumber: 1)
        }
        if !self.algorithm.isEmpty {
            try visitor.visitSingularStringField(value: self.algorithm, fieldNumber: 2)
        }
        if !self.issuerName.isEmpty {
            try visitor.visitSingularStringField(value: self.issuerName, fieldNumber: 3)
        }
        if !self.issuerID.isEmpty {
            try visitor.visitSingularBytesField(value: self.issuerID, fieldNumber: 4)
        }
        if !self.issuerDomain.isEmpty {
            try visitor.visitSingularStringField(value: self.issuerDomain, fieldNumber: 5)
        }
        if !self.subjectName.isEmpty {
            try visitor.visitSingularStringField(value: self.subjectName, fieldNumber: 6)
        }
        if !self.subjectID.isEmpty {
            try visitor.visitSingularBytesField(value: self.subjectID, fieldNumber: 7)
        }
        if !self.subjectDomain.isEmpty {
            try visitor.visitSingularStringField(value: self.subjectDomain, fieldNumber: 8)
        }
        if !self.name.isEmpty {
            try visitor.visitSingularStringField(value: self.name, fieldNumber: 9)
        }
        if !self.id.isEmpty {
            try visitor.visitSingularBytesField(value: self.id, fieldNumber: 10)
        }
        if !self.domain.isEmpty {
            try visitor.visitSingularStringField(value: self.domain, fieldNumber: 11)
        }
        if !self.publicKey.isEmpty {
            try visitor.visitSingularBytesField(value: self.publicKey, fieldNumber: 12)
        }
        if self.notValidBefore.bitPattern != 0 {
            try visitor.visitSingularDoubleField(value: self.notValidBefore, fieldNumber: 13)
        }
        if self.notValidAfter.bitPattern != 0 {
            try visitor.visitSingularDoubleField(value: self.notValidAfter, fieldNumber: 14)
        }
        if !self.`extension`.isEmpty {
            try visitor.visitRepeatedMessageField(value: self.`extension`, fieldNumber: 15)
        }
        try { if let v = self._signature {
            try visitor.visitSingularBytesField(value: v, fieldNumber: 16)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static func ==(lhs: PBCertificate, rhs: PBCertificate) -> Bool {
        if lhs.version != rhs.version {return false}
        if lhs.algorithm != rhs.algorithm {return false}
        if lhs.issuerName != rhs.issuerName {return false}
        if lhs.issuerID != rhs.issuerID {return false}
        if lhs.issuerDomain != rhs.issuerDomain {return false}
        if lhs.subjectName != rhs.subjectName {return false}
        if lhs.subjectID != rhs.subjectID {return false}
        if lhs.subjectDomain != rhs.subjectDomain {return false}
        if lhs.name != rhs.name {return false}
        if lhs.id != rhs.id {return false}
        if lhs.domain != rhs.domain {return false}
        if lhs.publicKey != rhs.publicKey {return false}
        if lhs.notValidBefore != rhs.notValidBefore {return false}
        if lhs.notValidAfter != rhs.notValidAfter {return false}
        if lhs.`extension` != rhs.`extension` {return false}
        if lhs._signature != rhs._signature {return false}
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}

extension PBElement: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = "Element"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "key"),
        2: .same(proto: "value"),
    ]
    
    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
                case 1: try { try decoder.decodeSingularStringField(value: &self.key) }()
                case 2: try { try decoder.decodeSingularStringField(value: &self.value) }()
                default: break
            }
        }
    }
    
    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        if !self.key.isEmpty {
            try visitor.visitSingularStringField(value: self.key, fieldNumber: 1)
        }
        if !self.value.isEmpty {
            try visitor.visitSingularStringField(value: self.value, fieldNumber: 2)
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static func ==(lhs: PBElement, rhs: PBElement) -> Bool {
        if lhs.key != rhs.key {return false}
        if lhs.value != rhs.value {return false}
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}
