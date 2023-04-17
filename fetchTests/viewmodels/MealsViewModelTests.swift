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
        let thumbnailCache = CacheManager()
        vm = MealsViewModel(api: api, thumbnailCache: thumbnailCache)
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
    }
    
    func testLoadData() {
        let api = vm.api as! MealsAPIServiceMock

        let expectation = XCTestExpectation(description: "Load data")
        
        vm.loadData()

        vm.reloadData = {
            XCTAssertEqual(api.getMealsCounter, 1)
            XCTAssertEqual(self.vm.count, 2)
            XCTAssertEqual(self.vm.getMealName(of: 0).string, "Meal 1")
            XCTAssertEqual(self.vm.getMealName(of: 1).string, "Meal 2")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetThumbnail() {
        let api = vm.api as! MealsAPIServiceMock
        let meal1 = Meal(id: "1", name: "Meal 1", thumbnail: "https://fetch.com/meal1.jpg")
        vm.setMeals([meal1])
        
        let expectation = XCTestExpectation(description: "Get thumbnail")
        let testImg = UIImage(named: "test_img", in: Bundle(for: type(of: self)), with: nil)

        vm.getThumbnail(of: 0) { image in
            XCTAssertEqual(api.fetchImageCount, 1)
            XCTAssertEqual(image, testImg)
            XCTAssertEqual(self.vm.thumbnailCache.retrieve(id: meal1.thumbnail), testImg)
            XCTAssertFalse(self.vm.thumbnailCache.isNil(id: meal1.thumbnail))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
