//
//  FetchLabel.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import UIKit

class FetchLabel: UILabel {
    
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
