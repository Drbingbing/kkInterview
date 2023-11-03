//
//  KKServiceTypeTest.swift
//  KKApiTests
//
//  Created by 鍾秉辰 on 2023/11/3.
//

import XCTest
@testable import KKApi

final class KKServiceTypeTest: XCTestCase {

    func testEquals() {
        XCTAssertTrue(MockKKService() != KKService())
    }
}
