//
//  MealsAPIService.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealsAPIService: MealsAPIProtocol {
    
    private let api: APIService
    
    init(api: APIService = APIService()) {
        self.api = api
    }
    
    public func getMeals(category: MealCategory) async -> [Meal]? {
        guard let url = URL(string: API.Path.getMealsByCategory(category.rawValue)) else { return nil}
        
        let result: Result<MealResponse, Error> = await api.get(url: url)
        switch result {
        case .failure(_):
            return nil
        case .success(let response):
            return response.toMeals()
        }
    }
    
    public func getMealDetail(id: String) async -> Meal? {
        guard let url = URL(string: API.Path.getMealDetailsById(id)) else { return nil }
        
        let result: Result<MealResponse, Error> = await api.get(url: url)
        switch result {
        case .failure(_):
            return nil
        case .success(let response):
            return response.toMeals().first
        }
    }
    
    public func fetchImage(url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        let result = await api.download(url: url)
        switch result {
        case .failure(_):
            return nil
        case .success(let data):
            let image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal)
            return image
        }
    }
}
