//
//  AnyCertificate+PEMLikeSerializable.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/16.
//


extension AnyCertificate {
    /// Serialize certificate to PEM like string.
    /// - Parameter privateKey: Private key to sign this certificate
    /// - Returns: PEM like string
    public func pemLikeString() throws -> String {
        let data = try self.serialize()
        let serializer = PEMLikeSerializer(data, identifier: "P-CERTIFICATE")
        return serializer.generate()
    }
    
    /// Extract certificate from PEM like string
    /// - Parameter string: PEM like string
    public init(pemLikeString string: String) throws {
        let serializer = try PEMLikeSerializer(pemLikeString: string, identifier: "P-CERTIFICATE", matchIdentifier: true)
        
        guard let data = serializer.contents.first else {
            throw CertificateError.invalidPEMLikeStringLength
        }
        
        self = try Self(serialized: data)
    }
}
