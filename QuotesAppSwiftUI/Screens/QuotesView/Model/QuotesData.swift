//
//  QuotesList.swift
//  Quotes
//
//  Created by Zan on 07/04/2025.
//

import Foundation

struct QuotesData: Codable {
    
    let count, totalCount, page, totalPages: Int
    let lastItemIndex: Int
    let results: [Quote]
}
