//
//  RequestError.swift
//  Billiant
//
//  Created by macbook on 09.07.2023.
//

import UIKit

enum RequestError {
    case updateFailed
}

// MARK: - Extension

extension RequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .updateFailed:
            return NSLocalizedString("Update failed 😨", comment: "")
        }
    }
}
