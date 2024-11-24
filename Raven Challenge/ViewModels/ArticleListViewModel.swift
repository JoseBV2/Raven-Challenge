//
//  ArticleListViewModel.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation
import Combine

class ArticleListViewModel: ObservableObject {
    
    // MARK: - @Published properties
    
    @Published var articles: [Article] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // MARK: - Properties
    
    private var hasLoaded: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIService
    private let storage = ArticleStorage()
    
    // MARK: - Init
    
    
    init(apiService: APIService = APIService(), articles: [Article] = []) {
        self.apiService = apiService
        if storage.loadArticles().isEmpty {
            self.articles = articles
        } else {
            self.articles = storage.loadArticles()
        }
    }
    
    // MARK: - Methods
    
    func assignStoreArticles() {
        articles = storage.loadArticles()
        errorMessage = nil
    }
    
    func fetchArticles(force: Bool = false) {
        if hasLoaded && !force { return }
        isLoading = true
        apiService.fetch(endpoint: "/viewedd/7.json?api-key=\(APIConfig.apiKey)", responseType: NYTResponse.self)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { articles in
                self.articles = articles.results
                self.storage.saveArticles(self.articles)
                self.hasLoaded = true
            })
            .store(in: &self.cancellables)
    }
}
