//
//  ImageGallaryView.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//

import Foundation
import Combine
import UIKit
import SwiftUI
@Observable
class ImageGalleryViewModel: ObservableObject {
    // MARK: - Constants
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    let spacing: CGFloat = 20
    // MARK: - Variables
    var apiSession: APIService = APISession()
    private var cancellables = Set<AnyCancellable>()
    // MARK: - Publishers
    var coverages: [Coverages] = []
    var isDataLoaded: Bool = false
    var isShowAlert: Bool = false
    var alertMessage: String = ""
    // MARK: - Initializer
    init() {
        fetchCoverages()
    }
}
// MARK: - ImageGalleryService
extension ImageGalleryViewModel: ImageGalleryService {
    private func fetchCoverages() {
        let cancellable = self.apiCallToGetCoverages()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.isDataLoaded = true
                    self.isShowAlert = true
                    self.alertMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { (response) in
                self.isDataLoaded = true
                if let response = response {
                    self.coverages = response
                }
            })
        cancellables.insert(cancellable)
    }
}
