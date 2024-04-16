//
//  ImageGalleryEndPoint.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//
import Foundation

enum ImageGalleryEndPoint {
    case coverages
}
extension ImageGalleryEndPoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .coverages:
            guard let url = URL(string: URL.ImageGallery.coverages)
            else {preconditionFailure("Invalid URL format")}
            var request = URLRequest(url: url)
            request.httpMethod = URLRequest.Method.get.rawValue
            request.allHTTPHeaderFields = [URL.Key.contentType: URL.Header.JSON, URL.Key.accept: URL.Header.JSON]
            return request
        }
    }
}
