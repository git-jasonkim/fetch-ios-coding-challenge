//
//  MealsAPIService.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import Foundation

class MealAPIService: MealAPI {

    private let api: NetworkingManagerImpl
    
    init(api: NetworkingManagerImpl = NetworkingManager.shared) {
        self.api = api
    }
    
    public func getMeals(by category: String) async -> Result<[Meal], NetworkingManager.NetworkingError> {
        do {
            let response = try await api.request(.getMealsByCategory(name: category), type: MealResponse.self)
            return Result.success(response.toMeals())
        } catch {
            return Result.failure(error as? NetworkingManager.NetworkingError ?? .custom(error: error))
        }
    }
    
    public func getMealDetails(by id: String) async -> Result<Meal?, NetworkingManager.NetworkingError> {
        do {
            let response = try await api.request(.getMealDetails(id: id), type: MealResponse.self)
            return Result.success(response.toMeals().first)
        } catch {
            return Result.failure(error as? NetworkingManager.NetworkingError ?? .custom(error: error))
        }
        
    }
}
