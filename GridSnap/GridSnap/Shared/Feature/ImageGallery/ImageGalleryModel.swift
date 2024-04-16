//
//  ImageGalleryModel.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//

import Foundation
struct Coverages: Codable {
    let id, title: String?
    let language: String?
    let thumbnail: Thumbnail?
    let mediaType: Int?
    let coverageURL: String?
    let publishedAt, publishedBy: String?
    let backupDetails: BackupDetails?
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
    let pdfLink: String?
    let screenshotURL: String?
}
// MARK: - Thumbnail
struct Thumbnail: Codable {
    let id: String?
    let version: Int?
    let domain: String?
    let basePath: String?
    let key: String?
    let qualities: [Int]
    let aspectRatio: Double?
    var constructedImageUrl: URL? {
        guard let domain = domain, let basePath = basePath, let key = key else {
            return nil
        }
        guard let lastIndex = qualities.last else {
            return nil
        }
        let urlString = "\(domain)/\(basePath)/\(lastIndex)/\(key)"
        return URL(string: urlString)
    }
}

