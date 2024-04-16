//
//  ImageGridGallerySwiftApp.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//

import Combine
import UIKit
protocol APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
}
