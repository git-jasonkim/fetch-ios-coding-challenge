//
//  MealDetailsHeaderCell.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealDetailsHeaderCell: UICollectionViewCell {
    
    deinit {
        print("deinit MealDetailsHeaderCell")
    }
    
    public var mealSectionTitle: NSAttributedString? {
        didSet {
            guard let text = mealSectionTitle else { return }
            mealSectionLabel.attributedText = text
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
    
    private lazy var mealSectionLabel = FetchLabel()
    
    private func setupSubviews() {
        backgroundColor = Color.fetchOffWhite
        addSubview(mealSectionLabel)
        mealSectionLabel.anchor(centerX: nil, centerY: centerYAnchor, top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)
    }
}
