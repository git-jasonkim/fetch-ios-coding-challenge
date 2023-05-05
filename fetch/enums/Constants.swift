//
//  Constants.swift
//  fetch
//
//  Created by Jason Kim on 5/5/23.
//

import Foundation
import UIKit

enum Constants { }

extension Constants {
    enum Padding {
        static var leftSafeArea: CGFloat {
            return ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.left ?? .zero)
        }
        static var rightSafeArea: CGFloat {
            return ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.right ?? .zero)
        }
    }
}
