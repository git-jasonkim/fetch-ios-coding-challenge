//
//  MealsViewModel.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealsViewModel {
    
    deinit {
        print("deinit MealsViewModel")
    }
    
    internal let api: MealsAPIProtocol
    internal let thumbnailCache: CacheManager
    
    init(api: MealsAPIProtocol, thumbnailCache: CacheManager) {
        self.api = api
        self.thumbnailCache = thumbnailCache
    }
    
    private var _meals = [Meal]()

    
    public func setMeals(_ meals: [Meal]) {
        _meals = meals
    }

    public func getMeal(of index: Int) -> Meal {
        return _meals[index]
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
        return _meals.count
    }
    
    public func loadData() {
        Task {
            let meals = await api.getMeals(category: MealCategory.dessert)
            guard let meals = meals else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.setMeals(meals)
                self?.reloadData?()
            }
        }
    }
    
    public func getThumbnail(of index: Int, completion: @escaping ((UIImage?) -> ())) {
        let thumbnailUrl = getMeal(of: index).thumbnail
        
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
