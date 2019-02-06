//
//  iTunesAPILegacyTests.swift
//  iTunesAPILegacyTests
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import XCTest
@testable import iTunesAPILegacy

class iTunesAPILegacyTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: CoreData

    func testCoreDataMediaInsert() {

    }

    // MARK: Media API

//    func parseItems(_ data: Response) -> [Media]? {
//        return try? data.map([Media].self, atKeyPath: "results")
//    }
//
//    func testMediaAPI() {
//        let provider = API.mediaProvider
//        let target = MediaService.searchItunes
//        var mediaList = [Media]()
//
//        provider.request(target("matrix", .all)) { result in
//            switch result {
//            case .failure(let error):
//                debugPrint(error.localizedDescription)
//
//            case .success(let response):
//                mediaList = self.parseItems(response) ?? []
//            }
//
//        }
//    }

}
