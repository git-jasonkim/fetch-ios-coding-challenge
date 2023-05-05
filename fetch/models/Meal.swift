//
//  Meal.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import Foundation

struct Meal {
    let id: String
    let name: String
    let thumbnail: String
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: [String]
    let tags: String?
    let youtube: String?
    let ingredients: [Int: String]
    let measurements: [Int: String]
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: Double?
    
    init(id: String, name: String, thumbnail: String, drinkAlternate: String?, category: String?, area: String?, instructions: [String], tags: String?, youtube: String?, ingredients: [Int : String], measurements: [Int : String], source: String?, imageSource: String?, creativeCommonsConfirmed: String?, dateModified: Double?) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.drinkAlternate = drinkAlternate
        self.category = category
        self.area = area
        self.instructions = instructions
        self.tags = tags
        self.youtube = youtube
        self.ingredients = ingredients
        self.measurements = measurements
        self.source = source
        self.imageSource = imageSource
        self.creativeCommonsConfirmed = creativeCommonsConfirmed
        self.dateModified = dateModified
    }
    
    init(mealResponse: MealResponse.MealData, instructions: [String], ingredients: [Int: String], measurements: [Int: String]) {
        self.id = mealResponse.id
        self.name = mealResponse.name
        self.thumbnail = mealResponse.thumbnail
        self.drinkAlternate = mealResponse.drinkAlternate
        self.category = mealResponse.category
        self.area = mealResponse.area
        self.instructions = instructions
        self.tags = mealResponse.tags
        self.youtube = mealResponse.youtube
        self.ingredients = ingredients
        self.measurements = measurements
        self.source = mealResponse.source
        self.imageSource = mealResponse.imageSource
        self.creativeCommonsConfirmed = mealResponse.creativeCommonsConfirmed
        self.dateModified = mealResponse.dateModified
    }
    
    init(id: String, name: String, thumbnail: String) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.drinkAlternate = nil
        self.category = nil
        self.area = nil
        self.instructions = []
        self.tags = nil
        self.youtube = nil
        self.ingredients = [:]
        self.measurements = [:]
        self.source = nil
        self.imageSource = nil
        self.creativeCommonsConfirmed = nil
        self.dateModified = nil
    }
}
