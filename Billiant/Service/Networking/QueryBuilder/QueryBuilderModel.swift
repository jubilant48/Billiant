//
//  QueryBuilderModel.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Scheme

enum Scheme: String {
    case standart
    case http = "http"
    case https = "https"
    
    typealias Value = String
    var value: Value { getValue() }
    
    private func getValue() -> Value {
        switch self {
        case .http:
            return self.rawValue
        case .https:
            return self.rawValue
        case .standart:
            return ENV.SCHEME
        }
    }
}

// MARK: - Host

enum Host: String {
    case standart
    
    typealias Value = String
    var value: Value { getValue() }
    
    private func getValue() -> Value {
        switch self {
        case .standart:
            return ENV.HOST
        }
    }
}

// MARK: - Path

enum Path: String {
    case accounts = "/accounts"
    case slash = "/"
    
    typealias Value = String
    var value: Value { getValue() }
    
    private func getValue() -> Value {
        switch self {
        case .accounts:
            return self.rawValue
        case .slash:
            return self.rawValue
        }
    }
}

// MARK: - Parameter

enum Parameter: String {
    case take = "take"
    case skip = "skip"
    case id = "id"
    case title = "title"
    case startAmount = "startAmount"
}
