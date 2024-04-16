//
//  CachedAsyncImage.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//

import Foundation
import UIKit
import SwiftUI
struct CachedAsyncImageView: View {
    let url: URL
    let coverageId: String
    @State private var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            Asset.placeholder
                .resizable()
                .scaledToFill()
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        // Checking cache
        if let cachedImage = ImageCacheManager.shared.image(for: url, id: coverageId) {
            self.image = cachedImage
        } else {
            // If not in cache, fetch image
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let newCovrageImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = newCovrageImage
                    // cahce image
                    ImageCacheManager.shared.storeImage(newCovrageImage, for: url, id: coverageId)
                }
            }.resume()
        }
    }
}
