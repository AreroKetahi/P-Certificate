//
//  CertificateElementTests.swift
//
//
//  Created by Akivili Collindort on 2024/6/18.
//

import Testing
@testable import PCertificate
import Foundation

@Suite("Certificate Element Tests")
struct CertificateElementTests {
    @Test("Create elements")
    func createElements() async throws {
        let elements: [CertificateElement]
        elements = ["dom.test.0": "Testing", "dom.test.1": 842, "dom.test.2": Date.now, "dom.test.3": UUID()]
        #expect(elements.count == 4)
    }
}
