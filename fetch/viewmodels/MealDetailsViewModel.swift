//
//  MealDetailViewModel.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealDetailsViewModel {
    
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }


    private(set) var meal: Meal
    internal let api: MealAPI
    public var reloadData: (() -> ())?
    
    init(meal: Meal, api: MealAPI = MealAPIService()) {
        self.meal = meal
        self.api = api
    }
    
    public func getMealName() -> NSAttributedString {
        let name = meal.name
        var attributedText = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center

        attributedText = NSMutableAttributedString(string: "\(name)", attributes: Attributes.mealName)
        
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    public var thumbnailUrl: String {
        return meal.thumbnail
    }
    
    public let headersCount: Int = 3
    private let headers = ["", "Ingredients & Measurements", "Instructions"]
    public func getMealSectionTitle(of section: Int) -> NSAttributedString {
        
        let title = headers[section]
        var attributedText = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .left

        attributedText = NSMutableAttributedString(string: "\(title)", attributes: Attributes.mealDetailsHeaderTitle)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    public var count: Int {
        return instructionsCount + ingredientsMeasurementsCount
    }
    
    public var instructionsCount: Int {
        return meal.instructions.count
    }
    
    public var ingredientsMeasurementsCount: Int {
        return meal.ingredients.count
    }
    
    public func getMealInstruction(of index: Int) -> NSAttributedString {
        let instruction = meal.instructions[index]
        var attributedText = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .left

        attributedText = NSMutableAttributedString(string: "\(index + 1). \(instruction)", attributes: Attributes.mealDetailsInstruction)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    public func getMealIngredientMeasurement(of key: Int) -> NSAttributedString {
        let ingredient = meal.ingredients[key] ?? ""
        let measurement = meal.measurements[key] ?? ""
        var attributedText = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .left

        attributedText = NSMutableAttributedString(string: "\(key + 1). \(ingredient)", attributes: Attributes.mealDetailsIngredientMeasurement)
        if (!measurement.isEmpty) {
            attributedText.append(NSAttributedString(string: ", \(measurement)", attributes: Attributes.mealDetailsIngredientMeasurement))
        }
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    @MainActor
    public func loadData() async {
        let result = await api.getMealDetails(by: meal.id)
        switch result {
        case.failure(_):
            break
        case .success(let mealWithDetails):
            guard let mealWithDetails = mealWithDetails else { return }
            self.meal = mealWithDetails
            self.reloadData?()
        }

    }
}
