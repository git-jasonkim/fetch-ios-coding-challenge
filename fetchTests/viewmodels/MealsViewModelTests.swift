//
//  MealsViewModelTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/14/23.
//

import XCTest
@testable import fetch

class MealsViewModelTests: XCTestCase {
    
    var vm: MealsViewModel!
    
    override func setUp() {
        super.setUp()
        let api = MealsAPIServiceMock()
        vm = MealsViewModel(api: api)
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
    }
    
    func testLoadData() async {
        let api = vm.api as! MealsAPIServiceMock
        let expectation = XCTestExpectation(description: "Load data")

        vm.reloadData = {
            expectation.fulfill()
        }
        await vm.loadData()
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(api.getMealsCounter, 1)
        XCTAssertEqual(self.vm.count, 2)
        XCTAssertEqual(self.vm.getMealName(of: 0).string, "Meal 1")
        XCTAssertEqual(self.vm.getMealName(of: 1).string, "Meal 2")

    }

}
