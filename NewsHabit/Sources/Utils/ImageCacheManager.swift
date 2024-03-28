//
//  ImageCacheManager.swift
//  NewsHabit
//
//  Created by jiyeon on 3/27/24.
//

import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func cacheImage(forKey urlString: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: urlString))
    }
    
    func imageForKey(_ urlString: String) -> UIImage? {
        return cache.object(forKey: NSString(string: urlString))
    }
    
}
