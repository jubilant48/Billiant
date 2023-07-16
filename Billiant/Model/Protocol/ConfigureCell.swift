//
//  ConfigureCell.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Protocol

protocol ConfigureCell {
    static var reuseId: String { get }
    
    func configure<U: Hashable>(with value: U) throws
}
