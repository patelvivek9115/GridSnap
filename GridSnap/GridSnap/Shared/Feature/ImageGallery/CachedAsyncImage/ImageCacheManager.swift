//
//  ImageCachMangaer.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//

import Foundation
import SwiftUI
class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    init() {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0].appendingPathComponent("CoverageImageCache")
        
        // Create cache directory if it doesn't exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    // Function to retrieve image from cache
    func image(for url: URL, id: String) -> UIImage? {
        // Check memory cache first
        if let image = memoryCache.object(forKey: id as NSString) {
            return image
        }
        
        // Check disk cache
        let filePath = cacheDirectory.appendingPathComponent(id)
        if let data = try? Data(contentsOf: filePath), let image = UIImage(data: data) {
            // Store in memory cache for future access
            memoryCache.setObject(image, forKey: id as NSString)
            return image
        }
        
        return nil
    }
    
    // Function to store image in cache
    func storeImage(_ image: UIImage, for url: URL, id: String) {
        // Store in memory cache
        memoryCache.setObject(image, forKey: id as NSString)
        
        // Store in disk cache
        let filePath = cacheDirectory.appendingPathComponent(id)
        if let data = image.pngData() {
            try? data.write(to: filePath)
        }
    }
}
