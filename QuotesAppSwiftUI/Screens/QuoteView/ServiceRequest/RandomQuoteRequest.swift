//
//  QuoteRequest.swift
//  Quotes
//
//  Created by Zan on 07/04/2025.
//

import Foundation

struct RandomQuoteRequest: Router {
    
    typealias Response = Quote
    var method: HTTPMethod = .get
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.randomQuote.rawValue
}
