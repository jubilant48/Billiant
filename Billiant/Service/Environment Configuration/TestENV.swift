//
//  TestENV.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Class

final class TestENV: BaseENV {
    // MARK: - Enumeration
    
    enum File: String {
        case title = "TEST-Keys"
    }
    
    // MARK: - Init
    
    init() {
        super.init(resourceName: File.title.rawValue)
    }
}

// MARK: - Extension

extension TestENV: APIKeyable {
    // MARK: - Properties
    
    var SCHEME: String { dict.object(forKey: NamesSpace.scheme.rawValue) as? String ?? "" }
    var HOST: String { dict.object(forKey: NamesSpace.host.rawValue) as? String ?? "" }
}
