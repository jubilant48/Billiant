//
//  FormatterHelper.swift
//  Billiant
//
//  Created by macbook on 09.07.2023.
//

import UIKit

final class FormatterHelper {
    // MARK: - Enumeration
    
    enum LocaleFormat: String {
        case ru = "ru_RU"
        case us = "us_US"
    }
    
    // MARK: - Methods
    
    static func rounding(_ number: Double, afterDecimalPoint amount: Int) -> String {
        return String(format: "%.\(amount)f", number)
    }
    
    static func currncyFormat<T: Numeric>(_ numeric: T, format: LocaleFormat) -> String {
        let formatter = NumberFormatter(numberStyle: .currency, locale: format.rawValue.toLocale)
        let numericFormat = numeric.format(formatter: formatter)!
        
        return numericFormat
    }
    
    static func decimalFormat(_ numeric: Double, format: LocaleFormat) -> String {
        let formatter = NumberFormatter(numberStyle: .decimal, locale: format.rawValue.toLocale)
        let numericFormat = numeric.format(formatter: formatter)!
        
        return numericFormat
    }
}
