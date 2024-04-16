//
//  ImageGallaryView.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//

import SwiftUI
struct ImageGalleryView: View {
    @StateObject var viewModel = ImageGalleryViewModel()
    var body: some View {
        NavigationView {
            if !viewModel.isDataLoaded {
                VStack {
                    Spacer()
                    ProgressView(AppLiterals.loading)
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: viewModel.spacing) {
                        ForEach(viewModel.coverages, id: \.id) { coverage in
                            if let coverageId = coverage.id, let thumbnail = coverage.thumbnail, let imageUrl = thumbnail.constructedImageUrl {
                                imageView(imageUrl: imageUrl, coverageId: coverageId)
                            } else {
                                Asset.placeholder
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                    .padding()
                }
                .alert(isPresented: $viewModel.isShowAlert) {
                    let title = Text(AppLiterals.AlertMsg.alert)
                    let buttonTitle = Text(AppLiterals.AlertMsg.ok)
                    let msg = Text(viewModel.alertMessage)
                    return Alert(title: title, message: msg, dismissButton: .default(buttonTitle) {})
                }
            }
        }
    }
    @ViewBuilder func imageView(imageUrl: URL, coverageId: String) -> some View {
        GeometryReader { geometry in
            CachedAsyncImageView(url: imageUrl, coverageId: coverageId)
                .frame(width: geometry.size.width, height: geometry.size.width)
                .cornerRadius(10)
                .shadow(radius: 2)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    ImageGalleryView()
}
