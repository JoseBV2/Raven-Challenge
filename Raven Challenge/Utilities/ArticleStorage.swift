//
//  ArticleStorage.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation

class ArticleStorage {
    
    // MARK: - Properties
    
    private let storageKey = "stored_articles"
    
    // MARK: - Methods
    
    func deleteArticles() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }

    func saveArticles(_ articles: [Article]) {
        do {
            let data = try JSONEncoder().encode(articles)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON to be saved: \(jsonString)")
            }
            
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Error saving articles: \(error.localizedDescription)")
        }
    }


    func loadArticles() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            print("No data found for key: \(storageKey)")
            return []
        }

        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                print("Valid JSON Object: \(jsonObject)")

                let validData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                return try JSONDecoder().decode([Article].self, from: validData)
            } else {
                print("Data is not a valid JSON array.")
            }
        } catch {
            print("Error parsing data: \(error.localizedDescription)")
        }

        return []
    }


}
