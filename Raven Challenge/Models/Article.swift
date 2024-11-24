//
//  Article.swift
//  Raven Challenge
//
//  Created by Jóse Bustamante on 11/24/24.
//

import Foundation

struct Article: Identifiable, Codable {
    
    // MARK: - Properties
    
    let id: String
    let title: String
    let byline: String
    let publishedDate: String
    let abstract: String
    let imageURL: URL?

    // MARK: - Init
    
    init(id: String, title: String, byline: String, publishedDate: String, abstract: String, imageURL: URL?) {
          self.id = id
          self.title = title
          self.byline = byline
          self.publishedDate = publishedDate
          self.abstract = abstract
          self.imageURL = imageURL
      }
    
    // MARK: - Enum
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case byline
        case publishedDate = "published_date"
        case abstract
        case media
    }
    
    // MARK: - Media

    struct Media: Codable {
        let mediaMetadata: [MediaMetadata]

        enum CodingKeys: String, CodingKey {
            case mediaMetadata = "media-metadata"
        }
    }

    struct MediaMetadata: Codable {
        let url: String
    }

    // MARK: - Init decoder
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let idString = try? container.decode(String.self, forKey: .id) {
            self.id = idString
        } else if let idInt = try? container.decode(Int.self, forKey: .id) {
            self.id = String(idInt)
        } else {
            throw DecodingError.typeMismatch(
                String.self,
                DecodingError.Context(
                    codingPath: container.codingPath + [CodingKeys.id],
                    debugDescription: "ID is neither a String nor an Int"
                )
            )
        }

        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Untitled"
        byline = try container.decodeIfPresent(String.self, forKey: .byline) ?? "Unknown Author"
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate) ?? "Unknown Date"
        abstract = try container.decodeIfPresent(String.self, forKey: .abstract) ?? "No Description Available"
        if let mediaArray = try? container.decodeIfPresent([Media].self, forKey: .media),
           let firstMedia = mediaArray.first,
           let bestQuality = firstMedia.mediaMetadata.last {
            imageURL = URL(string: bestQuality.url)
        } else {
            imageURL = nil
        }
    }
    
    // MARK: - Encoder
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(byline, forKey: .byline)
        try container.encode(publishedDate, forKey: .publishedDate)
        try container.encode(abstract, forKey: .abstract)
        if let imageURL = imageURL {
            let mediaMetadata = MediaMetadata(url: imageURL.absoluteString)
            let media = Media(mediaMetadata: [mediaMetadata])
            try container.encode([media], forKey: .media)
        } else {
            try container.encodeNil(forKey: .media)
        }
    }
}


