//
//  EndpointTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/17/23.
//

import XCTest
@testable import fetch

class EndpointTests: XCTestCase {
    
    func testHostAndVersion() {
        XCTAssertEqual(API.Host.dev, "https://themealdb.com/")
        XCTAssertEqual(API.Host.prod, "https://themealdb.com/")
        
        XCTAssertEqual(API.Version.V1, "api/json/v1/\(Secret.APIKey)/")

    }
    
    func testGetMealsByCategory() {
        let baseUrl = BuildConfiguration.shared.baseURL
        XCTAssertEqual(API.Path.getMealsByCategory("Dessert"), baseUrl + "filter.php?c=Dessert")
    }
    
    func testGetMealDetailsById() {
        let baseUrl = BuildConfiguration.shared.baseURL
        XCTAssertEqual(API.Path.getMealDetailsById("1"), baseUrl + "lookup.php?i=1")
    }
    
}
