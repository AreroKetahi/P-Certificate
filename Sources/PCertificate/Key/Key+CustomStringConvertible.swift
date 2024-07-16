//
//  Key+CustomStringConvertible.swift
//
//
//  Created by Akivili Collindort on 2024/7/16.
//

import Foundation

// MARK: - CustomStringConvertible

extension Key: CustomStringConvertible {
    public var description: String {
        """
        P-Key Version \(self.version)
        
        Algorithm:    \(self.algorithm)
        Key Size:     \(self.keySize == 0 ? "Fixed" : String(self.keySize))
        Symmetry:     \(self.isSymmetry ? "Symmetry" : "Asymmetry")
        Transparency: \(self.transparency)
        
        Content: \(self.content.description)
        
        Key Identifier: \(self.id)
        Key Digest:     \(self.digest)
        """
    }
}
