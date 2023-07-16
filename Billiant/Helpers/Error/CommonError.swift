//
//  CommonError.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Enumeration

enum CommonError {
    case unwrappingError(_ file: String, _ line: Int)
    case castingError(_ file: String, _ line: Int)
}

// MARK: - Extension

extension CommonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unwrappingError(let filePath, let line):
            return NSLocalizedString("Unwrapping error in file \(filePath) to line \(line)", comment: "")
        case .castingError(let filePath, let line):
            return NSLocalizedString("Cast failed in file \(filePath) to line \(line)", comment: "")
        }
    }
}
