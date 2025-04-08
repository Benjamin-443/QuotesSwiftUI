//
//  StatusCode+Helper.swift
//  NetworkLayer
//
//  Created by Zan on 07/04/2025.
//

import Foundation

extension StatusCode {
    var isSuccess: Bool {
        (200..<300).contains(self)
    }
}
