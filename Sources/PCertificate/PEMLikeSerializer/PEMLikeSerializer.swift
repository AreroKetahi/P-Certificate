//
//  PEMLikeSerializer.swift
//  PCertificate
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

struct PEMLikeSerializer: Sendable {
    var identifier: String
    var contents: [Data]
    
    init(_ contents: Data..., identifier: String) {
        self.contents = .init(contents)
        self.identifier = identifier.uppercased()
    }
    
    init(_ contents: [Data], identifier: String) {
        self.contents = contents
        self.identifier = identifier.uppercased()
    }
    
    init(pemLikeString string: String, identifier: String, matchIdentifier: Bool = false) throws {
        self.identifier = identifier.uppercased()
        var result = [Data]()
        
        let beginAttribute = "-----BEGIN \(identifier)-----"
        let endAttribute = "-----END \(identifier)-----"
        
        // split serval chunks
        var string = string
        string = string.replacingOccurrences(of: "\(beginAttribute)\n\(endAttribute)", with: "\(beginAttribute)`\(endAttribute)")
        let strings = string.split(whereSeparator: { $0 == "`" })
        
        for string in strings {
            if matchIdentifier {
                guard string.prefix(beginAttribute.count) == beginAttribute && string.suffix(endAttribute.count) == endAttribute else {
                    throw CertificateError.identifierNotMatched(identifier: identifier)
                }
            }
            
            let strings = (string.split(separator: "\n").dropFirst().dropLast())
            guard let data = Data(base64Encoded: strings.joined()) else {
                throw CertificateError.pemLikeStringDataCourrpted
            }
            
            result.append(data)
        }
        
        self.contents = result
    }
    
    func generate() -> String {
        let beginAttribute = "-----BEGIN \(identifier)-----"
        let endAttribute = "-----END \(identifier)-----"
        
        var result = [String]()
        
        for content in contents {
            var base64Encoded = Substring(content.base64EncodedString())
            var splitContent = [Substring]()
            
            repeat {
                splitContent.append(base64Encoded.prefix(64))
                base64Encoded = base64Encoded.dropFirst(64)
            } while base64Encoded.count != 0
            
            result.append(
                """
                \(beginAttribute)
                \(splitContent.joined(separator: "\n"))
                \(endAttribute)
                """
            )
        }
        
        return result.joined(separator: "\n")
    }
}
