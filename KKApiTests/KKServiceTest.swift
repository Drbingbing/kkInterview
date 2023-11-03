//
//  KKServiceTest.swift
//  KKApiTests
//
//  Created by 鍾秉辰 on 2023/11/3.
//

import XCTest
@testable import KKApi

final class KKServiceTest: XCTestCase {

    func testDefault() {
        XCTAssertTrue(KKService().serverConfig == ServerConfig.production)
    }
    
    func testEquals() {
        let s1 = KKService()
        let s2 = KKService(serverConfig: ServerConfig.development)
        
        XCTAssertTrue(s1 == s1)
        XCTAssertTrue(s2 == s2)
        
        XCTAssertFalse(s1 == s2)
    }
    
    
}
