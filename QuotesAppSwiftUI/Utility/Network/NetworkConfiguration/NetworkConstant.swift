//
//  NetworkConstant.swift
//  NetworkLayer
//
//  Created by Zan on 07/04/2025.
//

import Foundation

public typealias StatusCode = Int
public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String : Any?]

var kTimeoutInterval: TimeInterval = 30.0
var kNetworkEnvironment: Environment = .development
var kRequestCachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData


