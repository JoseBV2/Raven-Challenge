//
//  ContentView.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import SwiftUI

import SwiftUI

struct ArticleListView: View {
    @StateObject private var viewModel = ArticleListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Header
                VStack(alignment: .leading) {
                    Text("The New York Times")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    Text("Most Popular Articles")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Articles List
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.articles) { article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                ArticleCardView(article: article)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchArticles()
            }
        }
    }
}

struct ArticleCardView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = article.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .cornerRadius(10)
                        .clipped()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(height: 150)
                        .cornerRadius(10)
                }
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
