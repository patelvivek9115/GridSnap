//
//  ImageGalleryServices.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//

import Foundation
import Combine

protocol ImageGalleryService {
    var apiSession: APIService { get }
}
extension ImageGalleryService {
    func apiCallToGetCoverages() -> AnyPublisher<[Coverages]?, APIError> {
        return apiSession.request(with: ImageGalleryEndPoint.coverages)
            .eraseToAnyPublisher()
    }
}
