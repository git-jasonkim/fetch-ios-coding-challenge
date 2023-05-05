//
//  EndpointTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/17/23.
//

import XCTest
@testable import fetch

class EndpointTests: XCTestCase {
    
    func testGetMealsByCategoryUrl() {
        let url = Endpoint.getMealsByCategory(name: "1").url?.absoluteString
        print(url)
        XCTAssertEqual(url, "https://themealdb.com/api/json/v1/1/filter.php?c=1")
        
    }
    
    func testGetMealDetailsUrl() {
        let url = Endpoint.getMealDetails(id: "1").url?.absoluteString
        XCTAssertEqual(url, "https://themealdb.com/api/json/v1/1/lookup.php?i=1")
    }
}
