//
//  ArticleStorageTest.swift
//  Raven ChallengeTests
//
//  Created by Jóse Bustamante on 11/24/24.
//

import XCTest
@testable import Raven_Challenge

final class ArticleStorageTests: XCTestCase {
    func testSaveAndLoadArticles() {
        let articles = [
            Article(
                id: "1",
                title: "Breaking News",
                byline: "By John Doe",
                publishedDate: "2024-11-24",
                abstract: "An example abstract.",
                imageURL: URL(string: "https://example.com/image1.jpg")
            ),
            Article(
                id: "2",
                title: "Another News",
                byline: "By Jane Doe",
                publishedDate: "2024-11-23",
                abstract: "Another example abstract.",
                imageURL: URL(string: "https://example.com/image2.jpg")
            )
        ]

        let storage = ArticleStorage()
        storage.saveArticles(articles)

        let loadedArticles = storage.loadArticles()
        XCTAssertEqual(loadedArticles.count, 2)
        XCTAssertEqual(loadedArticles.first?.title, "Breaking News")
        XCTAssertEqual(loadedArticles.last?.title, "Another News")
    }

    func testLoadArticlesWithCorruptedData() {
        UserDefaults.standard.set("corrupted data".data(using: .utf8), forKey: "stored_articles")

        let storage = ArticleStorage()
        let loadedArticles = storage.loadArticles()

        XCTAssertEqual(loadedArticles.count, 0)
    }
}
