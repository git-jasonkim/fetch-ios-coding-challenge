//
//  MealDetailViewModel.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealDetailsViewModel {
    
    deinit {
        print("deinit MealDetailsViewModel")
    }
    
    internal let api: MealsAPIProtocol
    internal let thumbnailCache: CacheManager

    init(meal: Meal, api: MealsAPIProtocol, thumbnailCache: CacheManager) {
        self._meal = meal
        self.api = api
        self.thumbnailCache = thumbnailCache
    }
    
    private var _meal: Meal
    
    public func setMeal(_ meal: Meal) {
        _meal = meal
    }

    public func getMealName() -> NSAttributedString {
        let name = _meal.name
        var attributedText = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center

        attributedText = NSMutableAttributedString(string: "\(name)", attributes: Attributes.mealName)
        
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    public var reloadData: (() -> ())?
    
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
        return _meal.instructions.count
    }
    
    public var ingredientsMeasurementsCount: Int {
        return _meal.ingredients.count
    }
    
    public func getMealInstruction(of index: Int) -> NSAttributedString {
        let instruction = _meal.instructions[index]
        var attributedText = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .left

        attributedText = NSMutableAttributedString(string: "\(index + 1). \(instruction)", attributes: Attributes.mealDetailsInstruction)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    public func getMealIngredientMeasurement(of key: Int) -> NSAttributedString {
        let ingredient = _meal.ingredients[key] ?? ""
        let measurement = _meal.measurements[key] ?? ""
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
    
    public func loadData() {
        Task {
            let meal = await api.getMealDetail(id: _meal.id)
            DispatchQueue.main.async {
                guard let meal = meal else { return }
                self.setMeal(meal)
                self.reloadData?()
            }
        }
    }
    
    public func getThumbnail(completion: @escaping ((UIImage?) -> ())) {
        let thumbnailUrl = _meal.thumbnail
        
        if let image = thumbnailCache.retrieve(id: thumbnailUrl) {
            completion(image)
            return
        }
        
        Task {
            let image = await api.fetchImage(url: thumbnailUrl)
            DispatchQueue.main.async { [weak self] in
                if let image = image {
                    self?.thumbnailCache.set(id: thumbnailUrl, image: image)
                }
                completion(image)
            }
        }
    }
    
}
