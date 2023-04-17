//
//  EnumTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/17/23.
//

import UIKit
import XCTest
@testable import fetch

class EnumTests: XCTestCase {
    
    func testReuseId() {
        XCTAssertEqual(ReuseId.cMealCell, "MealCell")
        XCTAssertEqual(ReuseId.cMealDetailsHeaderCell, "MealDetailsHeaderCell")
        XCTAssertEqual(ReuseId.cMealDetailsOverviewCell, "MealDetailsOverviewCell")
        XCTAssertEqual(ReuseId.cMealDetailsInstructionCell, "MealDetailsInstructionCell")
        XCTAssertEqual(ReuseId.cMealDetailsIngredientMeasurementCell, "MealDetailsIngredientMeasurementCell")
    }
    
    func testMeal() {
        XCTAssertEqual(MealCategory.init(rawValue: "Dessert"), MealCategory.dessert)
    }
    
    func testSecret() {
        XCTAssertEqual(Secret.APIKey, "1")
    }
    
    func testPadding() {
        let leftPadding = ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.left ?? .zero)
        let rightPadding = ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.right ?? .zero)
        
        XCTAssertEqual(Padding.leftSafeArea, leftPadding)
        XCTAssertEqual(Padding.rightSafeArea, rightPadding)
    }
    
    func testColor() {
        XCTAssertEqual(Color.fetchBlack, UIColor.rgba(r: 0, g: 0, b: 0, a: 1.0))
        XCTAssertEqual(Color.fetchGray170, UIColor.rgba(r: 170, g: 170, b: 170, a: 1.0))
        XCTAssertEqual(Color.fetchOffWhite, UIColor.rgba(r: 252, g: 252, b: 252, a: 1.0))
    }
    
    func testAttributes() {
        XCTAssertEqual(Attributes.mealName[.foregroundColor] as? UIColor, Color.fetchBlack)
        XCTAssertEqual(Attributes.mealName[.font] as? UIFont, UIFont.systemFont(ofSize: 16, weight: .bold))
        
        XCTAssertEqual(Attributes.mealDetailsHeaderTitle[.foregroundColor] as? UIColor, Color.fetchBlack)
        XCTAssertEqual(Attributes.mealDetailsHeaderTitle[.font] as? UIFont, UIFont.systemFont(ofSize: 16, weight: .medium))

        XCTAssertEqual(Attributes.mealDetailsIngredientMeasurement[.foregroundColor] as? UIColor, Color.fetchBlack)
        XCTAssertEqual(Attributes.mealDetailsIngredientMeasurement[.font] as? UIFont, UIFont.systemFont(ofSize: 13, weight: .medium))

        XCTAssertEqual(Attributes.mealDetailsInstruction[.foregroundColor] as? UIColor, Color.fetchBlack)
        XCTAssertEqual(Attributes.mealDetailsInstruction[.font] as? UIFont, UIFont.systemFont(ofSize: 14, weight: .medium))

    }
}
