//
//  MealsAPIServiceMock.swift
//  fetchTests
//
//  Created by Jason Kim on 4/14/23.
//

import XCTest
@testable import fetch

class MealsAPIServiceMock: MealAPI {
    var getMealDetailCounter = 0
    var getMealsCounter = 0
    var fetchImageCount = 0
    
    func getMeals(by category: String) async -> Result<[fetch.Meal], fetch.NetworkingManager.NetworkingError> {
        getMealsCounter += 1
        let meals = [
            Meal(id: "1", name: "Meal 1", thumbnail: "https://fetch.com/meal1.jpg"),
            Meal(id: "2", name: "Meal 2", thumbnail: "https://fetch.com/meal2.jpg")
        ]
        return Result.success(meals)

    }
    
    func getMealDetails(by id: String) async -> Result<fetch.Meal?, fetch.NetworkingManager.NetworkingError> {
        getMealDetailCounter += 1
        let mealWithDetails = Meal(
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
        return Result.success(mealWithDetails)
    }
    
}
