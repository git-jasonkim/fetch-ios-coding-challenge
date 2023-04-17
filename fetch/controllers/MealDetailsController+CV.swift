//
//  MealDetailsController+CV.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

final class MealDetailsController: UICollectionViewController {
    
    deinit {
        print("deinit MealDetailsController")
    }
    
    internal let vm: MealDetailsViewModel
    
    init(vm: MealDetailsViewModel, collectionViewLayout layout: UICollectionViewLayout) {
        self.vm = vm
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
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
    
    private func setupNavigation() {
        self.title = "Meal Details"
    }
    
    private func setupVM() {
        vm.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        vm.loadData()
    }
    
    private func setupCV() {
        collectionView.register(MealDetailsHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseId.cMealDetailsHeaderCell)
        collectionView.register(MealDetailsOverviewCell.self, forCellWithReuseIdentifier: ReuseId.cMealDetailsOverviewCell)
        collectionView.register(MealDetailsInstructionCell.self, forCellWithReuseIdentifier: ReuseId.cMealDetailsInstructionCell)
        collectionView.register(MealDetailsIngredientMeasurementCell.self, forCellWithReuseIdentifier: ReuseId.cMealDetailsIngredientMeasurementCell)
        
        collectionView.backgroundColor = Color.fetchOffWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.headersCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let mealDetailsHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReuseId.cMealDetailsHeaderCell, for: indexPath) as! MealDetailsHeaderCell
            mealDetailsHeaderCell.mealSectionTitle = vm.getMealSectionTitle(of: indexPath.section)
            return mealDetailsHeaderCell
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return vm.ingredientsMeasurementsCount
        case 2:
            return vm.instructionsCount
        default:
            fatalError("Unexpected numberOfItemsInSection section out of range")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let mealDetailsOverviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.cMealDetailsOverviewCell, for: indexPath) as! MealDetailsOverviewCell
            mealDetailsOverviewCell.mealName = vm.getMealName()
            vm.getThumbnail { image in
                guard let image = image else { return}
                mealDetailsOverviewCell.image = image
            }
            return mealDetailsOverviewCell
        case 1:
            let mealDetailsIngredientMeasurementCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.cMealDetailsIngredientMeasurementCell, for: indexPath) as! MealDetailsIngredientMeasurementCell
            mealDetailsIngredientMeasurementCell.ingredientMeasurement = vm.getMealIngredientMeasurement(of: indexPath.item)
            return mealDetailsIngredientMeasurementCell
        case 2:
            let mealDetailsInstructionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.cMealDetailsInstructionCell, for: indexPath) as! MealDetailsInstructionCell
            mealDetailsInstructionCell.instruction = vm.getMealInstruction(of: indexPath.item)
            return mealDetailsInstructionCell
        default:
            fatalError("Unexpected cellforitemat section")
        }
    }
    
}

extension MealDetailsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (section == 0) {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Padding.leftSafeArea, bottom: 24, right: Padding.rightSafeArea)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sidePadding = Padding.leftSafeArea + Padding.rightSafeArea
        
        switch indexPath.section {
        case 0:
            let size = CGSize(width: collectionView.frame.width - 32, height: 1000)
            let height = vm.getMealName().boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height + 8 + 300
            return CGSize(width: collectionView.frame.width - sidePadding, height: height)
        case 1:
            let size = CGSize(width: collectionView.frame.width - 32, height: 1000)
            let height = vm.getMealIngredientMeasurement(of: indexPath.item).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height + 8
            return CGSize(width: collectionView.frame.width - sidePadding, height: height)
        case 2:
            let size = CGSize(width: collectionView.frame.width - 32, height: 1000)
            let height = vm.getMealInstruction(of: indexPath.item).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height + 32
            return CGSize(width: collectionView.frame.width - sidePadding, height: height)
        default:
            fatalError("Unexpected section requiring sizeForItemAt")
        }
    }
}
