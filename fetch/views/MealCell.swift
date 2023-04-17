//
//  MealCell.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealCell: UICollectionViewCell {
    
    deinit {
        print("deinit MealCell")
    }
    
    public var mealName: NSAttributedString? {
        didSet {
            guard let text = mealName else { return }
            mealNameLabel.attributedText = text
        }
    }
    
    public var image: UIImage? {
        didSet {
            guard let image = image else { return }
            mealImageView.image = image
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
        mealNameLabel.attributedText = nil
        mealImageView.image = nil
    }
    
    private lazy var mealNameLabel = FetchLabel()
    
    private lazy var mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private func setupSubviews() {
        backgroundColor = Color.fetchOffWhite
        
        addSubview(mealImageView)
        mealImageView.anchor(centerX: nil, centerY: centerYAnchor, top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 0, width: 50, height: 50)
        
        addSubview(mealNameLabel)
        mealNameLabel.anchor(centerX: nil, centerY: centerYAnchor, top: nil, leading: mealImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)
    }
}
