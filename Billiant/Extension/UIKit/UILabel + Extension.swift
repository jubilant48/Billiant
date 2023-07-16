//
//  UILabel + Extension.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Extension

extension UILabel {
    // MARK: - Init
    
    convenience init(text: String, font: UIFont?) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
