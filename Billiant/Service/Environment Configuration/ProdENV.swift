//
//  ProdENV.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Class

final class ProdENV: BaseENV {
    // MARK: - Enumeration
    
    enum File: String {
        case title = "PROD-Keys"
    }
    
    // MARK: - Init
    
    init() {
        super.init(resourceName: File.title.rawValue)
    }
}

// MARK: - Extension

extension ProdENV: APIKeyable {
    // MARK: - Properties
    
    var SCHEME: String { dict.object(forKey: NamesSpace.scheme.rawValue) as? String ?? "" }
    var HOST: String { dict.object(forKey: NamesSpace.host.rawValue) as? String ?? "" }
}
