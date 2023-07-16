//
//  Account.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Structure

struct Account: Codable {
    var id: Int
    var title: String
    var startAmount: String
    var amount: String
    var createdAt: String
    var updatedAt: String
}

// MARK: - Extension

extension Account: Hashable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
