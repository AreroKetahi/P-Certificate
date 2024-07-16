//
//  CertificateChain+Unsafe.swift
//  
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - Unsafe Operations
@_spi(UnsafeCertificate)
extension CertificateChain {
    /// Unsafely create a new certificate chain.
    ///
    /// - Warning: This method may cause unexpected behaviors.
    ///
    /// - Parameter certificates: Certificate chain.
    /// - Returns: Unchecked sertificate chain.
    public static func withUnsafeCertificateChain(_ certificates: [Certificate<PublicKey>]) -> Self {
        Self.init(certificates: certificates)
    }
    
    /// Unsafaly insert a new certificate to the existed chain.
    ///
    /// - Warning: This method may break current certificate chain.
    /// - Parameters:
    ///   - newValue: New certificate.
    ///   - index: The index that certificate may want to insert to.
    public mutating func unsafeInsert(_ newValue: Certificate<PublicKey>, at index: Int) {
        self.certificates.insert(newValue, at: index)
    }
}
