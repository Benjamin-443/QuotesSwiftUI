//
//  QuotesRequest.swift
//  Quotes
//
//  Created by Zan on 07/04/2025.
//

import Foundation

struct QuotesRequest: Router {
    
    typealias Response = QuotesData
    var method: HTTPMethod = .get
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.quotes.rawValue
}
