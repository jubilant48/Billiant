//
//  Accounts.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Structure

struct Accounts: Codable {
    var items: [Account]
    var tail: Bool
}
