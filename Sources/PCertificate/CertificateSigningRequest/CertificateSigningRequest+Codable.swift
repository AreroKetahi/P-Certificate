//
//  CertificateSigningRequest+Codable.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/31.
//

import Foundation

extension CertificateSigningRequest: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        self = try .init(serialized: data)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let data = try self.serialize()
        try container.encode(data)
    }
}
