//
//  MealsController+CV.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

final class MealsController: UICollectionViewController {
    
    deinit {
        print("deinit MealsController")
    }
    
    public var selectedMeal: ((Meal) ->())?
    
    internal let vm: MealsViewModel
    
    init(vm: MealsViewModel, collectionViewLayout layout: UICollectionViewLayout) {
        self.vm = vm
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupCV()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func setupVM() {
        vm.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        vm.loadData()
    }
     
    private func setupCV() {
        collectionView.register(MealCell.self, forCellWithReuseIdentifier: ReuseId.cMealCell)
        
        collectionView.backgroundColor = Color.fetchGray170
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 1
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mealCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.cMealCell, for: indexPath) as! MealCell
        mealCell.mealName = vm.getMealName(of: indexPath.item)
        return mealCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let mealCell = cell as? MealCell else { return }
        vm.getThumbnail(of: indexPath.item) { image in
            guard let image = image else { return}
            mealCell.image = image
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMeal?(vm.getMeal(of: indexPath.item))
    }
    
}

extension MealsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
}

