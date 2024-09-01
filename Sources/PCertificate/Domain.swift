//
//  Domain.swift
//  
//
//  Created by Akivili Collindort on 2024/5/25.
//

import Foundation

/// Domain that P-Certificate Use.
public struct Domain: ExpressibleByStringInterpolation, Sendable, Hashable, CustomStringConvertible {
    var domains: [String]
    
    public init(stringLiteral value: String) {
        let domains = value.split(separator: ".")
        self.domains = domains.map { String($0) }
    }
    
    public mutating func append(_ newElement: String) {
        self.domains.append(newElement)
    }
    
    public mutating func append<S>(contentsOf newElements: S) where S.Element == String, S: Sequence {
        self.domains.append(contentsOf: newElements)
    }
    
    public subscript(index: Int) -> String {
        get {
            domains[index]
        }
        set {
            domains[index] = newValue
        }
    }
    
    func callAsFunction() -> String {
        return self.description
    }
    
    public var description: String {
        domains.joined(separator: ".")
    }
}

extension Domain: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.domains.description)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try .init(stringLiteral: container.decode(String.self))
    }
}
