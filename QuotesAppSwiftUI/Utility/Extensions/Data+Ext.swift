//
//  Data+Ext.swift
//  ListView
//
//  Created by Zan on 07/04/2025.
//

import Foundation


extension Data {
    // MARK: - Data
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
