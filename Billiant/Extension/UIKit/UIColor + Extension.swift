//
//  UIColor + Extension.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Extension

extension UIColor {
    // MARK: - Enumeration
    
    enum AssetName: String {
        case _FFFFFF_1E1E1E = "FFFFFF#1E1E1E"
        case _1E1E1E_FFFFFF = "1E1E1E#FFFFFF"
        case _1E1E1E_333333 = "1E1E1E#333333"
        case _FFFFFF_FFFFFF = "FFFFFF#FFFFFF"
        case _FFFFFF_4F4F4F = "FFFFFF#4F4F4F"
        case _333333_FFE600 = "333333#FFE600"
        case _FFE600_1E1E1E = "FFE600#1E1E1E"
        case _4F4F4F_333333 = "4F4F4F#333333"
        case _FFFFFF_FFE600 = "FFFFFF#FFE600"
    }
    
    // MARK: - Methods
    
    static func getYellow() -> UIColor {
        return #colorLiteral(red: 1, green: 0.9019607843, blue: 0, alpha: 1)
    }
    
    static func getBlack() -> UIColor {
        return #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
    }
    
    static func getWhite() -> UIColor {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static func getGray() -> UIColor {
        return #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
    }
    
    static func getPrimatyFontColor() -> UIColor {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    static func get(color: AssetName) -> UIColor {
        switch color {
        case ._FFFFFF_1E1E1E:
            return UIColor(named: color.rawValue)!
        case ._1E1E1E_FFFFFF:
            return UIColor(named: color.rawValue)!
        case ._1E1E1E_333333:
            return UIColor(named: color.rawValue)!
        case ._FFFFFF_FFFFFF:
            return UIColor(named: color.rawValue)!
        case ._FFFFFF_4F4F4F:
            return UIColor(named: color.rawValue)!
        case ._333333_FFE600:
            return UIColor(named: color.rawValue)!
        case ._FFE600_1E1E1E:
            return UIColor(named: color.rawValue)!
        case ._4F4F4F_333333:
            return UIColor(named: color.rawValue)!
        case ._FFFFFF_FFE600:
            return UIColor(named: color.rawValue)!
        }
    }
}
