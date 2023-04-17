//
//  MealsControllerTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/17/23.
//

import XCTest
@testable import fetch

class MealsControllerTests: XCTestCase {
    
    var controller: MealsController!
    
    override func setUp() {
        super.setUp()
        let api = MealsAPIServiceMock()
        let thumbnailCache = CacheManager()
        let vm = MealsViewModel(api: api, thumbnailCache: thumbnailCache)
        controller = MealsController(vm: vm, collectionViewLayout: UICollectionViewFlowLayout())
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
    
    func testCellForItemAt() {
        let cell = self.controller.collectionView(self.controller.collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell is MealCell)
        XCTAssertEqual(cell.reuseIdentifier, ReuseId.cMealCell)
    }
    
    func testCount() {
        XCTAssertEqual(self.controller.collectionView.numberOfItems(inSection: 0), 2)
    }
    
}
