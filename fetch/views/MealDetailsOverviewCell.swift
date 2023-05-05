//
//  MealDetailsOverviewCell.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class MealDetailsOverviewCell: UICollectionViewCell {
    
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
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
    }
    
    private lazy var mealNameLabel = FetchLabel()
    
    public lazy var mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private func setupSubviews() {
        backgroundColor = Color.fetchOffWhite
        
        addSubview(mealNameLabel)
        mealNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 16, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 0)

        addSubview(mealImageView)
        mealImageView.anchor(top: mealNameLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 16, paddingLeading: 16, paddingBottom: 16, paddingTrailing: 16, width: 0, height: 0)
        
    }
}
