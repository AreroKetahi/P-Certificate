//
//  OtherTests.swift
//
//
//  Created by Akivili Collindort on 2024/6/18.
//

import Testing
@testable import PCertificate


@Suite("Version Tests")
struct VersionTests {
    @Test("Create Version")
    func createVersion() async throws {
        let version: Version = "5.9.3"
        #expect(version.major == 5)
        #expect(version.minor == 9)
        #expect(version.patch == 3)
        #expect(version.mark == nil)
        
        let version2: Version = "3.5.9-beta"
        #expect(version2.mark == .beta)
        
        let version3: Version = "1.0.1-releaseCandidate"
        #expect(version3.mark == .custom("releaseCandidate"))
    }
    
    func testVersionDescription() async throws {
        let version: Version = "9.2.5-release"
        #expect(version.description == "9.2.5-release")
        
        let version2: Version = "3.3.8-private"
        #expect(version2.description == "3.3.8-private")
        
        let version3: Version = "2.8.5"
        #expect(version3.description == "2.8.5")
    }
}
