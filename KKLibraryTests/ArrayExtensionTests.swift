//
//  ArrayExtensionTests.swift
//  KKLibraryTests
//
//  Created by 鍾秉辰 on 2023/11/3.
//

import XCTest
@testable import KKLibrary

private struct TestModel: Equatable {
    var name: String
    var date: Int
}

final class ArrayExtensionTests: XCTestCase {
    
    private let remote: [TestModel] = [
        TestModel(name: "1", date: 0),
        TestModel(name: "2", date: 1),
        TestModel(name: "3", date: 2),
        TestModel(name: "4", date: 3),
        TestModel(name: "5", date: 4),
        TestModel(name: "6", date: 5),
        TestModel(name: "7", date: 6),
    ]
    
    func testMergeSameUserWithDifferenceDate() {
        
        let updated: [TestModel] = [
            TestModel(name: "1", date: 1),
            TestModel(name: "4", date: 6)
        ]
        
        let result = remote.merge(updated, on: { $0.name == $1.name }, uniquingKeysWith: { $1.date > $0.date ? $1 : $0 })
        
        XCTAssertTrue(result.count == 7)
        XCTAssertEqual(result[0], updated[0])
    }
    
    func testMergeNewUserWithSameDate() {
        
        let updated: [TestModel] = [
            TestModel(name: "8", date: 1),
            TestModel(name: "9", date: 2)
        ]
        
        let result = remote.merge(updated, on: { $0.name == $1.name }, uniquingKeysWith: { $1.date > $0.date ? $1 : $0 })
        
        XCTAssertEqual(result.count, 9)
        XCTAssertEqual(result.last, updated.last)
    }
    
    func testMergeNewUserAndSameUserWithSameDate() {
        
        let updated: [TestModel] = [
            TestModel(name: "8", date: 1),
            TestModel(name: "9", date: 2),
            TestModel(name: "1", date: 1),
            TestModel(name: "2", date: 2)
        ]
        
        let result = remote.merge(updated, on: { $0.name == $1.name }, uniquingKeysWith: { $1.date > $0.date ? $1 : $0 })
        
        XCTAssertEqual(result.count, 9)
        XCTAssertEqual(result.last, updated[1])
        XCTAssertEqual(result[0], updated[2])
    }
}
