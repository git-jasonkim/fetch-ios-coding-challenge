//
//  MealDetailsViewModelTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/14/23.
//

import XCTest
@testable import fetch

class MealDetailsViewModelTests: XCTestCase {
    
    var vm: MealDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        let api = MealsAPIServiceMock()
        let meal1 = Meal(id: "1", name: "Meal 1", thumbnail: "https://fetch.com/meal1.jpg")
        vm = MealDetailsViewModel(meal: meal1, api: api)
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
    }
    
    func testHeaderLabels() {
        XCTAssertEqual(vm.getMealSectionTitle(of: 0).string, "")
        XCTAssertEqual(vm.getMealSectionTitle(of: 1).string, "Ingredients & Measurements")
        XCTAssertEqual(vm.getMealSectionTitle(of: 2).string, "Instructions")
    }
    
    func testLoadData() async {
        let api = vm.api as! MealsAPIServiceMock
        let expectation = XCTestExpectation(description: "Load data")
        
        vm.reloadData = {
            expectation.fulfill()
        }
        
        await vm.loadData()
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(api.getMealDetailCounter, 1)
        XCTAssertEqual(self.vm.count, 10)
        XCTAssertEqual(self.vm.instructionsCount, 2)
        XCTAssertEqual(self.vm.ingredientsMeasurementsCount, 8)
        XCTAssertEqual(self.vm.getMealName().string, "Meal 1")
        XCTAssertEqual(self.vm.getMealInstruction(of: 1).string, "2. Instruction 2")
        XCTAssertEqual(self.vm.getMealIngredientMeasurement(of: 1).string, "2. Ingredient 1, Measurement 1")
        XCTAssertEqual(self.vm.getMealIngredientMeasurement(of: 3).string, "3. Ingredient 3")

    }
}
