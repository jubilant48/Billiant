//
//  BaseENV.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Class

class BaseENV {
    // MARK: - Enumeration
    
    enum TypeFile: String {
        case plist = "plist"
    }
    
    enum NamesSpace: String {
        case scheme = "SCHEME"
        case host = "HOST"
    }
    
    // MARK: - Properties
    
    let dict: NSDictionary
    
    // MARK: - Init
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: TypeFile.plist.rawValue),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file \(resourceName) plist.")
        }
        
        self.dict = plist
    }
}
