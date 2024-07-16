//
//  Domain.swift
//  
//
//  Created by Akivili Collindort on 2024/5/25.
//

import Foundation

/// Domain that P-Certificate Use.
@dynamicCallable
public struct Domain: ExpressibleByStringLiteral, Sendable, Hashable, CustomStringConvertible {
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
    
    func dynamicallyCall(withKeywordArguments: KeyValuePairs<String, String>) -> String {
        return self.description
    }
    
    public var description: String {
        domains.joined(separator: ".")
    }
}