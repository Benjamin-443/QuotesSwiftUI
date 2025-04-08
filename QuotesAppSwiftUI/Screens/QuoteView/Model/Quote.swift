//
//  Quote.swift
//  Quotes
//
//  Created by Zan on 07/04/2025.
//

import Foundation

struct Quote: Identifiable, Codable, Hashable {
    
    let id, content, author, dateAdded: String
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case content, author, dateAdded
    }
}
