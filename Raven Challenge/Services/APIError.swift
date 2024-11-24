//
//  APIError.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation

enum APIError: LocalizedError {
    
    // MARK: - Error Cases
    
    case noInternet
    case serverError(statusCode: Int)
    case decodingError
    case unknown
    
    // MARK: - Descriptions

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "It seems you're not connected to the internet. Please check your connection and try again."
        case .serverError(let statusCode):
            return "Server returned an error. Status code: \(statusCode). Please try again later."
        case .decodingError:
            return "We encountered an error while processing the data. Please try again."
        case .unknown:
            return "An unknown error occurred. Please try again."
        }
    }
}
