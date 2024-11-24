//
//  ArticleListViewModelTests.swift
//  Raven ChallengeTests
//
//  Created by Jóse Bustamante on 11/24/24.
//

import XCTest
@testable import Raven_Challenge
import Combine

final class ArticleListViewModelTests: XCTestCase {
    var viewModel: ArticleListViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchArticlesFailure() {
        mockAPIService = MockAPIService(shouldFail: true)
        viewModel = ArticleListViewModel(apiService: mockAPIService)
        let expectation = XCTestExpectation(description: "Fetch articles failed")

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage, "Error message should not be nil.")
                XCTAssertEqual(errorMessage, "An unknown error occurred. Please try again.")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchArticles()

        wait(for: [expectation], timeout: 2.0)
    }
}

final class MockAPIService: APIService {
    var shouldFail: Bool

    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }

    override func fetch<T>(endpoint: String, responseType: T.Type) -> AnyPublisher<T, APIError> where T : Decodable {
        if shouldFail {
            return Fail(error: .unknown)
                 .eraseToAnyPublisher()
         } else {
             let mockArticle = Article(
                 id: "1",
                 title: "Mock Article",
                 byline: "By Mock Author",
                 publishedDate: "2024-11-24",
                 abstract: "This is a mock article.",
                 imageURL: URL(string: "https://example.com/mock.jpg")
             )

             if let mockData = [mockArticle] as? T {
                 return Just(mockData)
                     .setFailureType(to: APIError.self)
                     .eraseToAnyPublisher()
             } else {
                 return Fail(error: .unknown)
                     .eraseToAnyPublisher()
             }
         }
    }
}
