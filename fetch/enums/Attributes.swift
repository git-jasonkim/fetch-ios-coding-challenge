//
//  Attributes.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

enum Attributes {
    
    static let mealName: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: Color.fetchBlack,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
    ]
    
    static let mealDetailsHeaderTitle: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: Color.fetchBlack,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
    ]
    
    static let mealDetailsIngredientMeasurement: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: Color.fetchBlack,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)
    ]
    
    static let mealDetailsInstruction: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: Color.fetchBlack,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)
    ]
}
