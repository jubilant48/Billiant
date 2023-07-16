//
//  AccountsNetworkDataFetcher.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit
import Alamofire

// MARK: - Class

final class AccountsNetworkDataFetcher {
    // MARK: - Properties
    
    private var skip = 0
    private let take = 20
    private var tail: Bool = false
    
    // MARK: - Methods
    
    func next(completion: @escaping (Result<Accounts, Error>) -> Void) throws {
        let builder = QueryBuilder().set(scheme: .standart)
                                    .set(host: .standart)
                                    .set(path: .accounts)
                                    .set(method: .get)
                                    .set(param: .skip, value: String(skip))
                                    .set(param: .take, value: String(take))
        
        try builder.create(type: Data.self) { result in
            switch result {
            case .success(let data):
                guard let accounts = JSONHelper.decodeJSON(type: Accounts.self, from: data) else {
                    completion(.failure(CommonError.castingError(#fileID, #line)))
                    return
                }
                
                self.skip += self.take
                self.tail = accounts.tail
                
                completion(.success(accounts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func refresh(completion: @escaping (Result<Accounts, Error>) -> Void) throws {
        var skip = skip
        skip -= take
        
        let builder = QueryBuilder().set(scheme: .standart)
                                    .set(host: .standart)
                                    .set(path: .accounts)
                                    .set(method: .get)
                                    .set(param: .skip, value: String(skip))
                                    .set(param: .take, value: String(take))
        
        try builder.create(type: Data.self) { result in
            switch result {
            case .success(let data):
                guard let accounts = JSONHelper.decodeJSON(type: Accounts.self, from: data) else {
                    completion(.failure(CommonError.castingError(#fileID, #line)))
                    return
                }
                
                self.tail = accounts.tail
                
                completion(.success(accounts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
