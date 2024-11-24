//
//  Raven_ChallengeTests.swift
//  Raven ChallengeTests
//
//  Created by Jóse Bustamante on 11/24/24.
//

import XCTest
@testable import Raven_Challenge

final class ArticleModelTests: XCTestCase {
    func testArticleDecoding() throws {
        let json = """
        {
            "id": "1",
            "title": "Breaking News: SwiftUI Rocks",
            "byline": "By John Doe",
            "published_date": "2024-11-24",
            "abstract": "An example abstract.",
            "media": [{
                "media-metadata": [{
                    "url": "https://example.com/image.jpg"
                }]
            }]
        }
        """.data(using: .utf8)!
        
        let article = try JSONDecoder().decode(Article.self, from: json)

        XCTAssertEqual(article.id, "1")
        XCTAssertEqual(article.title, "Breaking News: SwiftUI Rocks")
        XCTAssertEqual(article.byline, "By John Doe")
        XCTAssertEqual(article.publishedDate, "2024-11-24")
        XCTAssertEqual(article.abstract, "An example abstract.")
        XCTAssertEqual(article.imageURL, URL(string: "https://example.com/image.jpg"))
    }

    func testArticleEncoding() throws {
        let article = Article(
            id: "1",
            title: "Breaking News: SwiftUI Rocks",
            byline: "By John Doe",
            publishedDate: "2024-11-24",
            abstract: "An example abstract.",
            imageURL: URL(string: "https://example.com/image.jpg")
        )

        let data = try JSONEncoder().encode(article)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

        XCTAssertEqual(json?["id"] as? String, "1")
        XCTAssertEqual(json?["title"] as? String, "Breaking News: SwiftUI Rocks")
        XCTAssertEqual(json?["byline"] as? String, "By John Doe")
        XCTAssertEqual(json?["published_date"] as? String, "2024-11-24")
        XCTAssertNotNil(json?["media"])
    }
}

