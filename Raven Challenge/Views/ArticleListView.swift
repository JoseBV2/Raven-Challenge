//
//  ArticleListView.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import SwiftUI

struct ArticleListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ArticleListViewModel
    
    // MARK: - Init
    
    init(articles: [Article] = []) {
        self._viewModel = StateObject(wrappedValue: ArticleListViewModel(articles: articles))
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
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
                .frame(alignment: .top)
                if viewModel.isLoading {
                    ProgressView("Loading Articles...")
                        .font(.title2)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .foregroundColor(.red)

                        Text("Oops! Something went wrong.")
                            .font(.headline)

                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Button(action: {
                            viewModel.fetchArticles(force: true)
                        }) {
                            Text("Try Again")
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 32)
                    }
                    .padding()
                    Text("Or click here to see stored data")
                        .font(.headline)
                        .onTapGesture {
                            viewModel.assignStoreArticles()
                        }
                } else if viewModel.articles.isEmpty {
                    Text("No articles found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
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
            }
            .refreshable {
                viewModel.fetchArticles(force: true) 
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchArticles()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ArticleListView(articles: [])
}
