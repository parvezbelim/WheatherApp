//
//  TheWheatherAppTests.swift
//  TheWheatherAppTests
//
//  Created by Parvez Belim on 11/6/21.
//

import XCTest
@testable import TheWheatherApp

class TheWheatherAppTests: XCTestCase {
    var objDBOperations: CityRecodsDBOperations!
    
    override func setUpWithError() throws {
        objDBOperations = CityRecodsDBOperations()
    }

    override func tearDownWithError() throws {
        objDBOperations = nil
    }
    
    func testCityRecords() throws{
        if let count = objDBOperations.getCityList()?.count{
            XCTAssertGreaterThan(count, 0)
        }
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
