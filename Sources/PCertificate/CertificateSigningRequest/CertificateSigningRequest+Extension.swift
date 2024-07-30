//
//  CertificateSigningRequest+Extension.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/31.
//

import Foundation

extension CertificateSigningRequest {
    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    private func encodeToString<T: Encodable>(_ value: T) throws -> String {
        let encodedValue = try encoder.encode(value)
        do {
            // unwrap the value to the pure string value.
            return try decoder.decode(String.self, from: encodedValue)
        } catch {
            return String(data: encodedValue, encoding: .utf8)!
        }
    }
    
    private func decodeFromString<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        do {
            let value = try decoder.decode(type, from: string.data(using: .utf8)!)
            return value
        } catch {
            let value = try encoder.encode(string)
            let actualValue = try decoder.decode(type, from: value)
            return actualValue
        }
    }
    
    /// Add `String` extension.
    /// - Parameters:
    ///   - domain: Domain of extension.
    ///   - value: String value of extension.
    public mutating func addExtension(at domain: Domain, value: String) {
        if let index = self.extension.firstIndex(where: { $0.key == domain }) {
            self.extension[index] = CertificateElement(key: domain, value: value)
        } else {
            self.extension.append(.init(key: domain, value: value))
        }
    }
    
    /// Add extension.
    /// - Parameters:
    ///   - domain: Domain of extension
    ///   - value: Domain value.
    public mutating func addExtension<T: Encodable>(at domain: Domain, value: T) throws {
        try self.addExtension(at: domain, value: encodeToString(value))
    }
    
    /// Get `String` value from extension
    /// - Parameter domain: Domain of extension
    /// - Returns: Value.
    public func getExtension(at domain: Domain) -> String? {
        self.extension.first {
            $0.key == domain
        }?.value
    }
    
    /// Get extension value to reference type.
    /// - Parameters:
    ///   - domain: Domain of extension.
    ///   - type: Reference type.
    /// - Returns: Value.
    public func getExtension<T: Decodable>(at domain: Domain, to type: T.Type) throws -> T? {
        guard let value = self.getExtension(at: domain) else {
            return nil
        }
        return try decodeFromString(type, from: value)
    }
    
    /// Delete extension and return raw `String` element.
    /// - Parameter domain: Domain of extension.
    /// - Returns: Deleted element, `nil` if the extension not exist.
    @discardableResult
    public mutating func deleteExtension(at domain: Domain) -> String? {
        guard let index = self.extension.firstIndex(where: {
            $0.key == domain
        }) else { return nil }
        
        let removedObject = self.extension.remove(at: index)
        return removedObject.value
    }
    
    /// Delete extension and return element as specific type.
    /// - Parameters:
    ///   - type: Type that result should be.
    ///   - domain: Domain of extension.
    /// - Returns: Deleted element, `nil` if the extension not exist.
    @discardableResult
    public mutating func deleteExtension<T: Decodable>(_ type: T.Type, at domain: Domain) throws -> T? {
        if let result = self.deleteExtension(at: domain) {
            return try decodeFromString(type, from: result)
        } else { return nil }
    }
}
