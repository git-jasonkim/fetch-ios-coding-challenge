//
//  UIImageView+Ext.swift
//  fetch
//
//  Created by Jason Kim on 5/5/23.
//

import UIKit

extension UIImageView {
    
    @MainActor
    func load(imgUrl: String, cache: ImageCache = ImageCache.shared) async {
        
        let forKey = imgUrl as NSString
        if let imageData = cache.object(forKey: forKey) {
            self.image = UIImage(data: imageData)
            return
        }
        
        do {
            let data = try await ImageRetriever().fetch(imgUrl)
            cache.set(object: data as NSData, forKey: forKey)
            self.image = UIImage(data: data)
        } catch {
            #if DEBUG
            print(error)
            #endif
            self.image = UIImage(named: "test_img")
        }
    }
    
}
