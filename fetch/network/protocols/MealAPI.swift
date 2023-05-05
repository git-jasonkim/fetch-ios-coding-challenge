//
//  MealAPI.swift
//  fetch
//
//  Created by Jason Kim on 5/5/23.
//

import Foundation

protocol MealAPI {
    func getMeals(by category: String) async -> Result<[Meal], NetworkingManager.NetworkingError>
    func getMealDetails(by id: String) async -> Result<Meal?, NetworkingManager.NetworkingError>
}
