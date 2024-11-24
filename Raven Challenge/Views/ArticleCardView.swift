//
//  ArticleCardView.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import SwiftUI

struct ArticleCardView: View {
    
    // MARK: - Properties
    
    let article: Article
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = article.imageURL {
                CachedAsyncImage(url: imageURL) {
                    AnyView(
                        ProgressView()
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    )
                }
                .frame(height: 200)
                .cornerRadius(10)
                .clipped()
            }
            
            Text(article.title)
                .font(.headline)
                .lineLimit(2)
            
            HStack {
                Text(article.byline)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(article.publishedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
