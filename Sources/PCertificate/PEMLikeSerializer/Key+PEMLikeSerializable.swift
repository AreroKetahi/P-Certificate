//
//  Key+PEMLikeSerializable.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/16.
//


extension Key {
    /// Serialize certificate to PEM like string.
    /// - Returns: PEM like string
    public func pemLikeString() throws -> String {
        let data = try self.serialize()
        let serializer = PEMLikeSerializer(data, identifier: "P-KEYSTORE")
        return serializer.generate()
    }
    
    /// Extract certificate from PEM like string
    /// - Parameter string: PEM like string
    public init(pemLikeString string: String) throws {
        let serializer = try PEMLikeSerializer(pemLikeString: string, identifier: "P-KEYSTORE", matchIdentifier: true)
        
        guard let data = serializer.contents.first else {
            throw CertificateError.invalidPEMLikeStringLength
        }
        
        self = try Self(serialized: data)
    }
}
