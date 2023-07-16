//
//  UIView + Extennsion.swift
//  Billiant
//
//  Created by macbook on 09.07.2023.
//

import UIKit

// MARK: - Extension

extension UIView {
    // MARK: - Methods
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
