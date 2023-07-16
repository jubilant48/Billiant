//
//  CreateAccount.swift
//  Billiant
//
//  Created by macbook on 16.07.2023.
//

import UIKit

// MARK: - Class

final class CrateAccount: AccountAlertStateProtocol {
    // MARK: - Enumeration
    
    enum Value: String {
        case title = "Создание счета"
        case titleButton = "Сохранить"
    }
    
    // MARK: - Properties
    
    var state: AccountAlertState = .create
    
    // MARK: - Methods
    
    func create(_ alert: AccountAlert) {
        alert.nameTextField.text = ""
        alert.amountTextField.text = ""
        
        alert.titleLabel.text = Value.title.rawValue
        alert.acceptButton.setTitle(Value.titleButton.rawValue, for: .normal)
    }
    
    func update(_ alert: AccountAlert) {
        let updateState = UpdateAccount()
        
        updateState.update(alert)
        alert.set(state: updateState)
    }
}
