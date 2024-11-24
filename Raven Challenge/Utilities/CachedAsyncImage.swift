//
//  CachedAsyncImage.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import SwiftUI

struct CachedAsyncImage: View {
    
    // MARK: - Properties
    
    let url: URL?
    let placeholder: () -> AnyView

    @State private var image: UIImage?
    
    // MARK: - View

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            placeholder()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    // MARK: - Private Methods

    private func loadImage() {
        guard let url = url else { return }
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let downloadedImage = UIImage(data: data)
            else { return }

            ImageCache.shared.setObject(downloadedImage, forKey: url.absoluteString as NSString)

            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }.resume()
    }
}
