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

    override func setUp() async throws {
        try await super.setUp()
        let api = MealsAPIServiceMock()
        let vm = MealsViewModel(api: api)
        
        let expectation = XCTestExpectation(description: "Load data")

        vm.reloadData = {
            expectation.fulfill()
        }
        
        controller = await MealsController(vm: vm, collectionViewLayout: UICollectionViewFlowLayout())
        await controller.vm.loadData()
        await fulfillment(of: [expectation], timeout: 1.0)

    }

    override func tearDown() {
        super.tearDown()
        controller = nil
    }

    func testCellForItemAt()  {
        let cell = self.controller.collectionView(self.controller.collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell is MealCell)
        XCTAssertEqual(cell.reuseIdentifier, ReuseId.cMealCell)
    }

    func testCount() {
        XCTAssertEqual(self.controller.collectionView.numberOfItems(inSection: 0), 2)
    }

}
