//
//  AuthrosRequest.swift
//  Quotes
//
//  Created by Zan on 07/04/2025.
//

import Foundation

struct AuthorsRequest: Router {
    
    typealias Response = AuthorsData
    var method: HTTPMethod = .get
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.authors.rawValue
}
