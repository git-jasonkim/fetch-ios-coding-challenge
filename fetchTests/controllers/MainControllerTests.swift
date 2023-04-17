//
//  MainControllerTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/16/23.
//

import XCTest
@testable import fetch

class MainControllerTests: XCTestCase {

    func testMainController() {
        let mainController = MainController()
        
        let api = MealsAPIService()
        let thumbnailCache = CacheManager()
        let vm = MealsViewModel(api: api, thumbnailCache: thumbnailCache)
        let mealsController = MealsController(vm: vm, collectionViewLayout: UICollectionViewFlowLayout())
        mainController.update(mealsController: mealsController)
        
        mainController.loadViewIfNeeded()
        XCTAssertEqual(mainController.title, "Fetch Meals")
        XCTAssertEqual(mainController.view.backgroundColor, Color.fetchOffWhite)
        XCTAssertEqual(mainController.view.subviews.count, 1)
        XCTAssertTrue(mainController.view.subviews.contains(mealsController.view))

    }

}
