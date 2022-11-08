//
//  PeopleTenTaskTests.swift
//  PeopleTenTaskTests
//
//  Created by Sandeepan Swain on 13/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import XCTest
@testable import PeopleTenTask

class PeopleTenTaskTests: XCTestCase {
    
    var sut:UserViewModel?
    
    override func setUp() {
           super.setUp()
           sut = UserViewModel()
       }
    
    override func tearDown() {
          sut = nil
          super.tearDown()
      }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
    
    func test_fetch_popular_photos() {
        // Given A apiservice
        let sut = self.sut!

        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
    
        sut.fetchPhotoDetails() { (eventsData) in
            expect.fulfill()
            XCTAssertEqual( eventsData.restaurants?.count, 15)
           // for photo in eventsData.restaurants?. {
              //  XCTAssertNotNil(photo)
            //}
        }
        wait(for: [expect], timeout: 3.1)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
