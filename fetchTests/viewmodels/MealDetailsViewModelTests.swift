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
        let thumbnailCache = CacheManager()
        let meal1 = Meal(id: "1", name: "Meal 1", thumbnail: "https://fetch.com/meal1.jpg")
        vm = MealDetailsViewModel(meal: meal1, api: api, thumbnailCache: thumbnailCache)
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
    
    func testLoadData() {
        let api = vm.api as! MealsAPIServiceMock
        let expectation = XCTestExpectation(description: "Load data")
        
        vm.loadData()
        vm.reloadData = {
            XCTAssertEqual(api.getMealDetailCounter, 1)
            XCTAssertEqual(self.vm.count, 10)
            XCTAssertEqual(self.vm.instructionsCount, 2)
            XCTAssertEqual(self.vm.ingredientsMeasurementsCount, 8)
            XCTAssertEqual(self.vm.getMealName().string, "Meal 1")
            XCTAssertEqual(self.vm.getMealInstruction(of: 1).string, "2. Instruction 2")
            XCTAssertEqual(self.vm.getMealIngredientMeasurement(of: 1).string, "1. Ingredient 1, Measurement 1")
            XCTAssertEqual(self.vm.getMealIngredientMeasurement(of: 3).string, "3. Ingredient 3")

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetThumbnail() {
        let api = vm.api as! MealsAPIServiceMock
        let expectation = XCTestExpectation(description: "Get thumbnail")
        let testImg = UIImage(named: "test_img", in: Bundle(for: type(of: self)), with: nil)

        vm.getThumbnail() { image in
            XCTAssertEqual(api.fetchImageCount, 1)
            XCTAssertEqual(image, testImg)
            XCTAssertEqual(self.vm.thumbnailCache.retrieve(id: "https://fetch.com/meal1.jpg"), testImg)
            XCTAssertFalse(self.vm.thumbnailCache.isNil(id: "https://fetch.com/meal1.jpg"))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
