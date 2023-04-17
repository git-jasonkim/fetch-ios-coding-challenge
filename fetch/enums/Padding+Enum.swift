//
//  Padding+Enum.swift
//  fetch
//
//  Created by Jason Kim on 4/17/23.
//

import UIKit

enum Padding {
    static var leftSafeArea: CGFloat {
        return ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.left ?? .zero)
    }
    static var rightSafeArea: CGFloat {
        return ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.right ?? .zero)
    }
}
