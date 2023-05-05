//
//  MealsViewModel.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealsViewModel {
    
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }

    
    private(set) var meals = [Meal]()
    internal let api: MealAPI
    
    init(api: MealAPI = MealAPIService()) {
        self.api = api
    }
    
    public func getMeal(of index: Int) -> Meal {
        return meals[index]
    }
    
    public func getThumbnailUrl(of index: Int) -> String {
        return meals[index].thumbnail
    }
    
    public func getMealName(of index: Int) -> NSAttributedString {
        let name = getMeal(of: index).name
        var attributedText = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .left

        attributedText = NSMutableAttributedString(string: "\(name)", attributes: Attributes.mealName)
        
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    public var reloadData: (() -> ())?
    
    public var count: Int {
        return meals.count
    }
    
    @MainActor
    public func loadData() async {
        let result = await api.getMeals(by: MealCategory.dessert.rawValue)
        switch result {
        case .failure(_):
            break
        case .success(let meals):
            self.meals = meals
            self.reloadData?()
        }
    }
    
}
