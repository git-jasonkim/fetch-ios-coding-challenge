//
//  MealsAPIServiceMock.swift
//  fetchTests
//
//  Created by Jason Kim on 4/14/23.
//

import XCTest
@testable import fetch

class MealsAPIServiceMock: MealsAPIProtocol {
    
    var getMealDetailCounter = 0
    var getMealsCounter = 0
    var fetchImageCount = 0
    
    func getMealDetail(id: String) async -> fetch.Meal? {
        getMealDetailCounter += 1
        return Meal(
            id: "1",
            name: "Meal 1",
            thumbnail: "https://fetch.com/meal1.jpg",
            drinkAlternate: nil,
            category: "Dessert",
            area: "American",
            instructions: [
                "Instruction 1", "Instruction 2"
            ],
            tags: "Chocolate,Desert,Snack",
            youtube: "https://www.youtube.com/watch?v=Pi89PqsAaAg",
            ingredients: [
                0: "Ingredient 0",
                1: "Ingredient 1",
                2: "Ingredient 2",
                3: "Ingredient 3",
                4: "Ingredient 4",
                5: "Ingredient 5",
                6: "Ingredient 6",
                7: "Ingredient 7"
            ],
            measurements: [
                0: "Measurement 0",
                1: "Measurement 1",
                2: "Measurement 2"
          ],
            source: "https://www.bbcgoodfood.com/recipes/2121648/bestever-chocolate-raspberry-brownies",
            imageSource: nil,
            creativeCommonsConfirmed: nil,
            dateModified: nil
        )
    }
    
    
    func getMeals(category: MealCategory) async -> [Meal]? {
        getMealsCounter += 1
        return [
            Meal(id: "1", name: "Meal 1", thumbnail: "https://fetch.com/meal1.jpg"),
            Meal(id: "2", name: "Meal 2", thumbnail: "https://fetch.com/meal2.jpg")
        ]
    }
    
    func fetchImage(url: String) async -> UIImage? {
        fetchImageCount += 1
        return UIImage(named: "test_img", in: Bundle(for: type(of: self)), compatibleWith: nil)
    }
    
}
