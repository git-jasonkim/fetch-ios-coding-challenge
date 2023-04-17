//
//  MainController.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

final class MainController: UIViewController {
    
    deinit {
        print("deinit MainController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSubviews()
    }
    
    internal func update(mealsController: MealsController?) {
        if let mealsController = mealsController {
            self.mealsController = mealsController
        }
    }
    
    private lazy var mealsController: MealsController = {
        let api = MealsAPIService()
        let thumbnailCache = CacheManager()
        let vm = MealsViewModel(api: api, thumbnailCache: thumbnailCache)
        let cv = MealsController(vm: vm, collectionViewLayout: UICollectionViewFlowLayout())
        cv.selectedMeal = { [weak self] meal in
            let vm = MealDetailsViewModel(meal: meal, api: api, thumbnailCache: thumbnailCache)
            let mealDetailsController = MealDetailsController(vm: vm, collectionViewLayout: UICollectionViewFlowLayout())
            self?.navigationController?.pushViewController(mealDetailsController, animated: true)
        }
        return cv
    }()
    
    private func setupSubviews() {
        view.backgroundColor = Color.fetchOffWhite
        if let mealsView = mealsController.view {
            addChild(mealsController)
            view.addSubview(mealsView)
            mealsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
        }
    }
    
    private func setupNavigation() {
        self.title = "Fetch Meals"
    }
    
}
