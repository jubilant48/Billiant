//
//  APIKeyable.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Protocol

protocol APIKeyable {
    var SCHEME: String { get }
    var HOST: String { get }
}

