//
//  NSMutableData+Append.swift
//  NetworkLayer
//
//  Created by Zan on 07/04/2025.
//

import Foundation

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
