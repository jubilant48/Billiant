//
//  Bool + Extension.swift
//  Billiant
//
//  Created by macbook on 04.06.2023.
//

import Foundation

// MARK: - Extension

extension Bool {
    // MARK: - Properties
    
    var data: NSData {
        var _self = self
        return NSData(bytes: &_self, length: MemoryLayout.size(ofValue: self))
    }
    
    // MARK: - Init
    
    init?(data: NSData) {
        guard data.length == 1 else { return nil }
        var value = false
        
        data.getBytes(&value, length: MemoryLayout<Bool>.size)
        
        self = value
    }
}
