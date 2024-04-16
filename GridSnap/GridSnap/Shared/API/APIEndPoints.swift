//
//  ImageGridGallerySwiftApp.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//
import Foundation
extension URL {
    enum Key {
        static let accept = "Accept"
        static let contentType = "Content-Type"
    }
    enum Header {
        static let JSON = "application/json"
    }
    enum ImageGallery {
        static let coverages = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
    }
}
