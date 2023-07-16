//
//  AccountCellViewModel.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Protocol

protocol AccountCellViewModel {
    var title: String { get }
    var amount: String { get }
}
