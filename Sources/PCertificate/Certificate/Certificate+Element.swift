//
//  Certificate+Element.swift
//
//
//  Created by Akivili Collindort on 2024/6/18.
//

import Foundation

/// Certificate Extension Element
///
/// - Important: This type should not be exist individually without ``Certificate``.
public struct CertificateElement: Sendable, Hashable {
    public var key: Domain
    public var value: String
    
    /// Create new certificate extension element.
    /// - Parameters:
    ///   - key: Domain of the element.
    ///   - value: Value of the element.
    ///
    /// Instead of creating individual elements, consider using ``Swift/Array/init(dictionaryLiteral:)`` to create a collection of elements.
    public init(key: Domain, value: String) {
        self.key = key
        self.value = value
    }
}

// MARK: - Array<CertificateElement> Extension
extension Array: @retroactive ExpressibleByDictionaryLiteral where Element == CertificateElement {
    /// Create a collection of the certificate element.
    /// - Parameter elements: Elements.
    ///
    /// Consider do not call this initializer directly, create an collection use dictionary literal instead.
    ///
    /// ```swift
    /// let elements: [CertificateElement] = [
    ///     "element.1": "Hello!", 
    ///     "element.2": true,
    ///     "element.3": 152,
    ///     "element.4": Date.now
    /// ]
    /// ```
    ///
    /// - Tip: You can use any type which conform to `Codable` to create a element array.
    public init(dictionaryLiteral elements: (Domain, (any Codable))...) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let mappedElement = try! elements.map { key, value in
            let encodedValue = try encoder.encode(value)
            do {
                // unwrap the value to the pure string value.
                let string = try decoder.decode(String.self, from: encodedValue)
                return (key, string)
            } catch {
                return (key, String(data: encodedValue, encoding: .utf8)!)
            }
        }
        
        self = mappedElement.map { domain, value in
            return .init(key: domain, value: value)
        }
    }
}
