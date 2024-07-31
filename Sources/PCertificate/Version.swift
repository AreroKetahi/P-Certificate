//
//  Version.swift
//  
//
//  Created by Akivili Collindort on 2024/5/25.
//

import Foundation

/// P-Certificate semantic version implementation
///
/// See also [https://semver.org](https://semver.org) for more detail about sermantic versioning.
public struct Version: ExpressibleByStringInterpolation, CustomStringConvertible, Sendable, Hashable, Equatable {
    var major: Int
    var minor: Int
    var patch: Int
    var mark: Mark?
    
    public init(stringLiteral value: String) {
        let values = value.split(separator: ".").flatMap { $0.split(separator: "-") }
        self.major = Int(values[0])!
        self.minor = Int(values[1]) ?? 0
        self.patch = Int(values[2]) ?? 0
        if Int(values.last!) == nil {
            self.mark = .init(rawValue: String(values.last!))
        }
    }
    
    /// Create new version
    /// - Parameters:
    ///   - major: Major version
    ///   - minor: Minor verison
    ///   - patch: Patch version
    ///   - mark: Additional labels
    init(_ major: Int, _ minor: Int, _ patch: Int, mark: Mark? = nil) {
        self.major = major
        self.minor = minor
        self.patch = patch
        self.mark = mark
    }
    
    public var description: String {
        if let mark {
            "\(major).\(minor).\(patch)-\(mark.rawValue)"
        } else {
            "\(major).\(minor).\(patch)"
        }
    }
}

extension Version {
    /// P-Certificate version 1.0.0
    ///
    /// The minor and patch version are been omit.
    static let v1: Self = "1.0.0"
}

extension Version {
    public enum Mark: RawRepresentable, Sendable, Hashable, Equatable {
        case release
        case alpha
        case beta
        case custom(String)
        
        public init?(rawValue: String) {
            switch rawValue {
                case "release": self = .release
                case "alpha": self = .alpha
                case "beta": self = .beta
                default: self = .custom(rawValue)
            }
        }
        
        public var rawValue: String {
            switch self {
                case .release: "release"
                case .alpha: "alpha"
                case .beta: "beta"
                case .custom(let string): string
            }
        }
    }
}

extension Version: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try .init(stringLiteral: container.decode(String.self))
    }
}
