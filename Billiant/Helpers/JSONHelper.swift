//
//  JSONHelper.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Class

final class JSONHelper {
    // MARK: - Methods
    
    static func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let response = try? decoder.decode(type.self, from: data) else { return nil }
        
        return response
    }
}
