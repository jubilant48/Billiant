//
//  Validator.swift
//  Billiant
//
//  Created by macbook on 09.07.2023.
//

import UIKit

final class Validator {
    // MARK: - Enumeration
    
    enum ValidationType: String {
        case double = "Double"
    }
    
    // MARK: - Methods
    
    static func validate(text: String, for type: ValidationType) throws -> Bool {
        switch type {
        case .double:
            return Validator().checkDoubleType(text: text)
        }
    }
}

// MARK: - Validate methods

extension Validator {
    func checkDoubleType(text: String) -> Bool {
        guard let _ = Double(text) else {
            return false
        }
        
        return true
    }
}
