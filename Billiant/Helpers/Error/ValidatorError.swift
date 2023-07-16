//
//  ValidatorError.swift
//  Billiant
//
//  Created by macbook on 09.07.2023.
//

import UIKit

enum ValidatorError {
    // MARK: - Enumeration
    
    enum ValidationType: String{
        case startAmount = "стартовой суммы"
    }
    
    // MARK: - Cases
    
    case validationError(_ type: ValidationType)
}

// MARK: - Extension

extension ValidatorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .validationError(let type):
            return NSLocalizedString("Неккоректный ввод \(type.rawValue)!", comment: "")
        }
    }
}
