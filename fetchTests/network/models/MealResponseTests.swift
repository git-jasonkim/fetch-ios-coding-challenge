//
//  MealResponseTests.swift
//  fetchTests
//
//  Created by Jason Kim on 4/17/23.
//

import XCTest
@testable import fetch

class MealResponseTests: XCTestCase {
    
    func testToMeals() {
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MealDetailsResponse", ofType: "json") else {
            fatalError("MealDetailsResponse.json not found")
        }

        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert MealDetailsResponse.json to String")
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert MealDetailsResponse.json to Data")
        }
        
        guard let result = try? JSONDecoder().decode(MealResponse.self, from: jsonData) else {
            fatalError("Unable to decode MealDetailsResponse.json to Data")

        }

        let expectedMeal = Meal(
            id: "52860",
            name: "Chocolate Raspberry Brownies",
            thumbnail: "https://www.themealdb.com/images/media/meals/yypvst1511386427.jpg",
            drinkAlternate: nil,
            category: "Dessert",
            area: "American",
            instructions: [
                "Heat oven to 180C/160C fan/gas 4. Line a 20 x 30cm baking tray tin with baking parchment. Put the chocolate, butter and sugar in a pan and gently melt, stirring occasionally with a wooden spoon. Remove from the heat.", "Stir the eggs, one by one, into the melted chocolate mixture. Sieve over the flour and cocoa, and stir in. Stir in half the raspberries, scrape into the tray, then scatter over the remaining raspberries. Bake on the middle shelf for 30 mins or, if you prefer a firmer texture, for 5 mins more. Cool before slicing into squares. Store in an airtight container for up to 3 days."
            ],
            tags: "Chocolate,Desert,Snack",
            youtube: "https://www.youtube.com/watch?v=Pi89PqsAaAg",
            ingredients: [
                0: "Dark Chocolate",
                1: "Milk Chocolate",
                2: "Salted Butter",
                3: "Light Brown Soft Sugar",
                4: "Eggs",
                5: "Plain Flour",
                6: "Cocoa",
                7: "Raspberries"
            ],
            measurements: [
                0: "200g",
                1: "100g",
                2: "250g",
                3: "400g",
                4: "4 large",
                5: "140g",
                6: "50g",
                7: "200g"            ],
            source: "https://www.bbcgoodfood.com/recipes/2121648/bestever-chocolate-raspberry-brownies",
            imageSource: nil,
            creativeCommonsConfirmed: nil,
            dateModified: nil
        )
                    
        XCTAssertEqual(result.toMeals().first?.id, expectedMeal.id)
        XCTAssertEqual(result.toMeals().first?.instructions, expectedMeal.instructions)
        XCTAssertEqual(result.toMeals().first?.ingredients, expectedMeal.ingredients)
        XCTAssertEqual(result.toMeals().first?.measurements, expectedMeal.measurements)

    }
    
}
