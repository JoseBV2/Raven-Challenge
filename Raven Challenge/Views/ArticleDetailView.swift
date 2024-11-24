//
//  ArticleDetailView.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import SwiftUI

struct ArticleDetailView: View {
    
    // MARK: - Properties
    
    let article: Article
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageURL = article.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                            .frame(height: 200)
                    }
                }

                Text(article.title)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                HStack {
                    Text(article.byline)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(article.publishedDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                Text(article.abstract)
                    .font(.body)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Article Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

