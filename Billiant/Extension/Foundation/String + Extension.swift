//
//  String + Extension.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import Foundation

// MARK: - Extension

extension String {
    // MARK: - Properties
    
    var toLocale: Locale { return Locale(identifier: self) }
}
