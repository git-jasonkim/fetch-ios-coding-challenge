//
//  MealDetailsIngredientMeasurementCell.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealDetailsIngredientMeasurementCell: UICollectionViewCell {
    
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }

    
    public var ingredientMeasurement: NSAttributedString? {
        didSet {
            guard let text = ingredientMeasurement else { return }
            ingredientMeasurementLabel.attributedText = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private lazy var ingredientMeasurementLabel = FetchLabel()
    
    private func setupSubviews() {
        backgroundColor = Color.fetchOffWhite
        addSubview(ingredientMeasurementLabel)
        ingredientMeasurementLabel.anchor(centerX: nil, centerY: centerYAnchor, top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)
    }
}
