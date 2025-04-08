//
//  AuthorsList.swift
//  Quotes
//
//  Created by Zan on 07/04/2025.
//

import Foundation

struct AuthorsData: Codable {
    
    let count, totalCount, page, totalPages: Int
    let lastItemIndex: Int
    let results: [Author]
}

// MARK: - Result
struct Author: Codable, Identifiable, Hashable {
    
    let id, name, bio, description: String
    let link: String
    let quoteCount: Int
    let slug, dateAdded, dateModified: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, bio, description, link, quoteCount, slug, dateAdded, dateModified
    }
}
