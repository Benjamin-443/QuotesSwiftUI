//
//  Environment.swift
//  NetworkLayer
//
//  Created by Zan on 07/04/2025.
//

import Foundation

// MARK: - Environment

/// Find the list environments
public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    public var url: String {
        switch self {
        case .development:
            return "https://api.quotable.io/"
        case .staging:
            return "https://api.quotable.io/"
        case .production:
            return "https://api.quotable.io/"
        }
    }
}
