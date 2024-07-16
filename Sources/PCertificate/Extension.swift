//
//  Extension.swift
//
//
//  Created by Akivili Collindort on 2024/5/24.
//

import Foundation

// !!!: This file declears serval private methods
// !!!: Do not expose

extension UUID {
    var dataRepresentation: Data {
        let (u0, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, u14, u15) = self.uuid
        let data = [u0, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, u14, u15]
        return Data(data)
    }
    
    init?(_ dataRepresentation: Data) {
        guard dataRepresentation.count == 16 else {
            return nil
        }
        
        let u0 = dataRepresentation[0]
        let u1 = dataRepresentation[1]
        let u2 = dataRepresentation[2]
        let u3 = dataRepresentation[3]
        let u4 = dataRepresentation[4]
        let u5 = dataRepresentation[5]
        let u6 = dataRepresentation[6]
        let u7 = dataRepresentation[7]
        let u8 = dataRepresentation[8]
        let u9 = dataRepresentation[9]
        let u10 = dataRepresentation[10]
        let u11 = dataRepresentation[11]
        let u12 = dataRepresentation[12]
        let u13 = dataRepresentation[13]
        let u14 = dataRepresentation[14]
        let u15 = dataRepresentation[15]
        
        self = UUID(uuid: (u0, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, u14, u15))
    }
}

extension Data {
    var hexadecimalRepresentation: String {
        [UInt8](self).map { byte in
            return String(format: "%02x", byte)
        }.joined()
    }
    
    init?(_ hexadecimalString: String) {
        guard hexadecimalString.count % 2 == 0 else {
            return nil
        }
        
        var data = Data()
        var index = hexadecimalString.startIndex
        
        while index < hexadecimalString.endIndex {
            let nextIndex = hexadecimalString.index(index, offsetBy: 2)
            let hexByte = hexadecimalString[index..<nextIndex]
            if let byte = UInt8(hexByte, radix: 16) {
                data.append(byte)
            } else {
                return nil
            }
            index = nextIndex
        }
        
        self = data
    }
}
