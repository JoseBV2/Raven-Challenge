//
//  APIService.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation
import Combine

class APIService {
    
    // MARK: - Methods
    
    func fetch<T: Decodable>(
        endpoint: String,
        responseType: T.Type
    ) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: "\(APIConfig.baseURL)\(endpoint)") else {
            return Fail(error: APIError.unknown).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                guard 200..<300 ~= response.statusCode else {
                    throw APIError.serverError(statusCode: response.statusCode)
                }
                return output.data
            }
            .decode(type: responseType, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError {
                    return urlError.code == .notConnectedToInternet ? .noInternet : .unknown
                }
                if error is DecodingError {
                    return .decodingError
                }
                if let apiError = error as? APIError {
                    return apiError
                }
                return .unknown
            }
            .eraseToAnyPublisher()
    }
}

