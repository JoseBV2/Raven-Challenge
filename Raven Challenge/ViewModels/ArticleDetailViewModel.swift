//
//  ArticleDetailViewModel.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation

class ArticleDetailViewModel: ObservableObject {
    
    // MARK: - @Published properties
    
    @Published var article: Article
    
    // MARK: - Init

    init(article: Article) {
        self.article = article
    }
}

