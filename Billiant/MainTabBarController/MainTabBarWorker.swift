//
//  MainTabBarWorker.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Main tab bar service

final class MainTabBarService {
    // MARK: - Enumeration
    
    enum IconBarName: String {
        case accounts = "wallet"
        case deadline = "deadline"
        case target = "target"
        case planned = "planned_operation"
    }
    
    enum BarTitle: String {
        case accounts = "Счета"
        case planned = "Планируемые операции"
        case tergets = "Цели"
        case plan = "План"
    }
}
