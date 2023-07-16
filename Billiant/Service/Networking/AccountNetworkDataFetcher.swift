//
//  AccountBuilder.swift
//  Billiant
//
//  Created by macbook on 04.06.2023.
//

import UIKit

// MARK: - Class

final class AccountNetworkDataFetcher {
    // MARK: - Methods
    
    func create(title: String, startAmount: String, completion: @escaping (Result<Int, Error>) -> Void) throws {
        let builder = QueryBuilder().set(scheme: .standart)
                                    .set(host: .standart)
                                    .set(path: .accounts)
                                    .set(method: .post)
                                    .set(param: .title, value: title)
                                    .set(param: .startAmount, value: startAmount)
        
        try builder.create(type: Data.self) { result in
            switch result {
            case .success(let data):
                guard let text = String(data: data, encoding: .utf8), let id = Int(text) else {
                    completion(.failure(CommonError.unwrappingError(#file, #line)))
                    return
                }
                
                completion(.success(id))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(id: Int, title: String, startAmount: String, completion: @escaping (Result<Bool, Error>) -> Void) throws {
        let builder = QueryBuilder().set(scheme: .standart)
                                    .set(host: .standart)
                                    .set(path: .accounts)
                                    .add(path: .slash)
                                    .addPath(string: String(id))
                                    .set(method: .patch)
                                    .set(param: .title, value: title)
                                    .set(param: .startAmount, value: startAmount)
        
        try builder.create(type: Bool.self) { result in
            switch result {
            case .success(let isUpdated):
                completion(.success(isUpdated))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) throws {
        let builder = QueryBuilder().set(scheme: .standart)
                                    .set(host: .standart)
                                    .set(path: .accounts)
                                    .add(path: .slash)
                                    .addPath(string: String(id))
                                    .set(method: .delete)
        
        try builder.create(type: Bool.self) { result in
            switch result {
            case .success(let isDelete):
                completion(.success(isDelete))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
