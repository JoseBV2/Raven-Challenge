//
//  ImageCache.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import SwiftUI

class ImageCache {
    
    // MARK: - Properties
    
    static let shared = NSCache<NSString, UIImage>()
    
}
