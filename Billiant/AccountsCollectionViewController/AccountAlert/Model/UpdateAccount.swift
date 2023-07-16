//
//  UpdateAccount.swift
//  Billiant
//
//  Created by macbook on 16.07.2023.
//

import UIKit

// MARK: - Class

final class UpdateAccount: AccountAlertStateProtocol {
    // MARK: - Enumeration
    
    enum Value: String {
        case title = "Редактирование счета"
        case titleButton = "Обновить"
    }
    
    // MARK: - Properties
    
    var state: AccountAlertState = .update
    
    // MARK: - Methods
    
    func create(_ alert: AccountAlert) {
        let createState = CrateAccount()
        createState.create(alert)
        
        alert.set(state: createState)
    }
    
    func update(_ alert: AccountAlert) {
        alert.titleLabel.text = Value.title.rawValue
        alert.acceptButton.setTitle(Value.titleButton.rawValue, for: .normal)
    }
}
