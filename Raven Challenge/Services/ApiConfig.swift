//
//  ApiConfig.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation

struct APIConfig {
    
    // MARK: - Static properties
    
    static let baseURL = "https://api.nytimes.com/svc/mostpopular/v2"
    static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["NYT_API_KEY"] as? String else {
            fatalError("NYT_API_KEY is missing in Build Settings or Info.plist")
        }
        return key
    }
}
