//
//  AuthorDetailRequest.swift
//  QuotesAppSwiftUI
//
//  Created by Zan on 07/04/2025.
//

import Foundation

struct AuthorDetailRequest: Router {
    
    typealias Response = AuthorDetail
    var method: HTTPMethod = .get
    var pathParameters: [String]
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.authors.rawValue
    
    init(id: String) {
        pathParameters = [id]
    }
}
