//
//  Numeric + Extension.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import Foundation

// MARK: - Extesnion

extension Numeric {
    // MARK: - Methods
    
    func format(formatter: NumberFormatter) -> String? {
        if let num = self as? NSNumber { return formatter.string(from: num) }
        return nil
    }
}
