//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Zan on 07/04/2025.
//

import Foundation

// MARK: - End Points
/// Find the list of web API's end-points

enum EndPoint: String {
    /// This end-point will return the list of users.
    case randomQuote = "random"
    case quotes = "quotes"
    case authors = "authors"
}
