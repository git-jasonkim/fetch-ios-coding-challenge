//
//  CacheManager.swift
//  fetch
//
//  Created by Jason Kim on 4/13/23.
//

import UIKit

typealias ThumbnailImageUrl = String

class CacheManager {
        
    private var thumbnailImageCache = NSCache<NSString, UIImage>()
    
    public func set(id: ThumbnailImageUrl, image: UIImage) {
        let forKey = NSString(string: id)
        self.thumbnailImageCache.setObject(image, forKey: forKey)
    }
    
    public func retrieve(id: ThumbnailImageUrl) -> UIImage? {
        let forKey = NSString(string: id)
        return thumbnailImageCache.object(forKey: forKey)
    }
    
    public func isNil(id: ThumbnailImageUrl) -> Bool {
        let forKey = NSString(string: id)
        return thumbnailImageCache.object(forKey: forKey) == nil
    }
}
