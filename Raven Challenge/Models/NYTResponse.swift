//
//  NYTResponse.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation

struct NYTResponse: Decodable {
    
    // MARK: - Properties
    
    let results: [Article]
}
