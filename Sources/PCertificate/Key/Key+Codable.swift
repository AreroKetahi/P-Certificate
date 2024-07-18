//
//  Key+Codable.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/18.
//

import Foundation

extension Key: Codable {
    public func encode(to encoder: any Encoder) throws {
        let serialized = try self.serialize()
        
        var container = encoder.singleValueContainer()
        try container.encode(serialized)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let serialized = try container.decode(Data.self)
        self = try .init(serialized: serialized)
    }
}
