//
//  AccountAlertStateProtocol.swift
//  Billiant
//
//  Created by macbook on 16.07.2023.
//

import UIKit

// MARK: - Protocol

protocol AccountAlertStateProtocol {
    // MARK: - Properties
    
    var state: AccountAlertState { get }
    
    // MARK: - Methods
    
    func create(_ alert: AccountAlert)
    func update(_ alert: AccountAlert)
}

