//
//  UIColor+Ext.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

extension UIColor {
    
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
}
