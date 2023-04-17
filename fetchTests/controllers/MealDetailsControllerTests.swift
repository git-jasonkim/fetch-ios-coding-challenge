//
//  MealDetailsControllerTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/17/23.
//

import XCTest
@testable import fetch

class MealDetailsControllerTests: XCTestCase {
    
    var controller: MealDetailsController!
    
    override func setUp() {
        super.setUp()
        let api = MealsAPIServiceMock()
        let thumbnailCache = CacheManager()
        let meal = Meal(id: "1", name: "Meal 1", thumbnail: "https://fetch.com/meal1.jpg")
        let vm = MealDetailsViewModel(meal: meal, api: api, thumbnailCache: thumbnailCache)
    
        controller = MealDetailsController(vm: vm, collectionViewLayout: UICollectionViewFlowLayout())
        
        controller.vm.loadData()
        let expectation = XCTestExpectation(description: "Load data")
        controller.vm.reloadData = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    override func tearDown() {
        super.tearDown()
        controller = nil
    }
        
    func testViewForSupplementaryElementOfKind() {
        XCTAssertEqual(self.controller.collectionView.numberOfSections, 3)
        
        let cellAtSection0 = self.controller.collectionView(self.controller.collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cellAtSection0 is MealDetailsHeaderCell)
        XCTAssertEqual(cellAtSection0.reuseIdentifier, ReuseId.cMealDetailsHeaderCell)
        XCTAssertEqual((cellAtSection0 as? MealDetailsHeaderCell)?.mealSectionTitle?.string, "")
        
        let cellAtSection1 = self.controller.collectionView(self.controller.collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1))
        XCTAssertTrue(cellAtSection1 is MealDetailsHeaderCell)
        XCTAssertEqual(cellAtSection1.reuseIdentifier, ReuseId.cMealDetailsHeaderCell)
        XCTAssertEqual((cellAtSection1 as? MealDetailsHeaderCell)?.mealSectionTitle?.string, "Ingredients & Measurements")
        
        let cellAtSection2 = self.controller.collectionView(self.controller.collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 2))
        XCTAssertTrue(cellAtSection2 is MealDetailsHeaderCell)
        XCTAssertEqual(cellAtSection2.reuseIdentifier, ReuseId.cMealDetailsHeaderCell)
        XCTAssertEqual((cellAtSection2 as? MealDetailsHeaderCell)?.mealSectionTitle?.string, "Instructions")

    }
    
    func testCellForItemAt() {
        let cellAtSection0Item0 = self.controller.collectionView(self.controller.collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cellAtSection0Item0 is MealDetailsOverviewCell)
        XCTAssertEqual(cellAtSection0Item0.reuseIdentifier, ReuseId.cMealDetailsOverviewCell)
        
        let cellAtSection1Item0 = self.controller.collectionView(self.controller.collectionView, cellForItemAt: IndexPath(item: 0, section: 1))
        XCTAssertTrue(cellAtSection1Item0 is MealDetailsIngredientMeasurementCell)
        XCTAssertEqual(cellAtSection1Item0.reuseIdentifier, ReuseId.cMealDetailsIngredientMeasurementCell)
        
        let cellAtSection2Item0 = self.controller.collectionView(self.controller.collectionView, cellForItemAt: IndexPath(item: 0, section: 2))
        XCTAssertTrue(cellAtSection2Item0 is MealDetailsInstructionCell)
        XCTAssertEqual(cellAtSection2Item0.reuseIdentifier, ReuseId.cMealDetailsInstructionCell)
    }
    
    
    func testNumberOfItemsInSections() {
        XCTAssertEqual(self.controller.collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(self.controller.collectionView.numberOfItems(inSection: 1), 8)
        XCTAssertEqual(self.controller.collectionView.numberOfItems(inSection: 2), 2)

    }
    
}
