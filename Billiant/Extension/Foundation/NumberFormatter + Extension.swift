//
//  NumberFormatter + Extension.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import Foundation

// MARK: - Extension

extension NumberFormatter {
    // MARK: - Init
    
    convenience init(numberStyle: NumberFormatter.Style, groupingSeparator: String?, decimalSeparator: String?) {
        self.init()
        set(numberStyle: numberStyle, groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
    }

    convenience init(numberStyle: NumberFormatter.Style, locale: Locale) {
        self.init()
        set(numberStyle: numberStyle, locale: locale)
    }
    
    // MARK: - Methods

    func set(numberStyle: NumberFormatter.Style, groupingSeparator: String?, decimalSeparator: String?) {
        self.locale = nil
        self.numberStyle = numberStyle
        self.groupingSeparator = groupingSeparator
        self.decimalSeparator = decimalSeparator
    }

    func set(numberStyle: NumberFormatter.Style, locale: Locale?) {
        self.numberStyle = numberStyle
        self.locale = locale
    }
}

