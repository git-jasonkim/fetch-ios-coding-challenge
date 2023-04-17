//
//  MealsAPI.swift
//  fetch
//
//  Created by Jason Kim on 4/14/23.
//

import UIKit

protocol MealsAPIProtocol {
    func getMeals(category: MealCategory) async -> [Meal]?
    func getMealDetail(id: String) async -> Meal?
    func fetchImage(url: String) async -> UIImage?
}
