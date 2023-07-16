//
//  QueryBuilderErrors.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Enumeration

enum QueryBuilderError {
    case methodsNotFound
    case typeMustBe(String)
}

// MARK: - Extension

extension QueryBuilderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .methodsNotFound:
            return NSLocalizedString("Methods not found", comment: "")
        case .typeMustBe(let type):
            return NSLocalizedString("Error type. Type must be \(type)", comment: "")
        }
    }
}
