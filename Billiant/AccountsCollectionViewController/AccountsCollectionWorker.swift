//
//  AccountsCollectionWorker.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol AccountsInteractorService {
    func nextAccounts(result: Result<Accounts, Error>) throws -> Accounts
    func refreshAccounts(result: Result<Accounts, Error>) throws -> Accounts
    func createAccount(result: Result<Int, Error>) throws
    func updateAccount(id: Int, result: Result<Bool, Error>, title: String, startAmount: String) throws -> Accounts
    func deleteAccount(id: Int, result: Result<Bool, Error>) throws
}

// MARK: - Accounts collection service

final class AccountsCollectionService {
    // MARK: - Properties
    
    private var accounts: Accounts?
}

// MARK: - Interacor service

extension AccountsCollectionService: AccountsInteractorService {
    // MARK: - Next accounts
    
    func nextAccounts(result: Result<Accounts, Error>) throws -> Accounts {
        
        switch result {
        case .success(let accounts):
            self.accounts = accounts
            
            guard let accounts = self.accounts else { throw CommonError.unwrappingError(#fileID, #line) }
            
            return accounts
        case .failure(let error):
            throw error
        }
    }
    
    // MARK: - Refresh accounts
    
    func refreshAccounts(result: Result<Accounts, Error>) throws -> Accounts {
        switch result {
        case .success(let accounts):
            do {
                try self.refresh(accounts: accounts)
                
                guard let accounts = self.accounts else { throw CommonError.unwrappingError(#fileID, #line) }
                
                return accounts
            } catch let error {
                throw error
            }
        case .failure(let error):
            throw error
        }
    }
    
    private func refresh(accounts new: Accounts) throws {
        guard var accounts = accounts else { throw CommonError.unwrappingError(#fileID, #line) }
        
        try new.items.forEach { item in
            if accounts.items.contains(item) {
                guard let index = accounts.items.firstIndex(of: item) else {
                    throw CommonError.unwrappingError(#fileID, #line)
                }
                
                accounts.items[index] = item
            } else {
                accounts.items.append(item)
            }
        }
        
        self.accounts = accounts
    }
    
    // MARK: - Create account
    
    func createAccount(result: Result<Int, Error>) throws {
        switch result {
        case .success(_):
            return
        case .failure(let error):
            throw error
        }
    }
    
    // MARK: - Update account
    
    func updateAccount(id: Int, result: Result<Bool, Error>, title: String, startAmount: String) throws -> Accounts {
        switch result {
        case .success(let isUpdated):
            if isUpdated {
                
                do {
                    guard let _ = try self.update(id, title: title, startAmount: startAmount) else { throw CommonError.unwrappingError(#fileID, #line) }
                    
                    guard let accounts = self.accounts else { throw CommonError.unwrappingError(#fileID, #line) }
                    
                    return accounts
                } catch let error {
                    throw error
                }
                
            } else {
                throw RequestError.updateFailed
            }
        case .failure(let error):
            throw error
        }
    }
    
    private func update(_ id: Int, title: String, startAmount: String) throws -> Account? {
        guard try Validator.validate(text: startAmount, for: .double) else { throw ValidatorError.validationError(.startAmount) }
        
        guard var accounts = accounts else { throw CommonError.unwrappingError(#fileID, #line) }
        var updateAccount: Account?
        
        for (index, account) in accounts.items.enumerated() {
            if account.id == id {
                accounts.items[index].startAmount = startAmount
                accounts.items[index].amount = startAmount
                accounts.items[index].title = title
                updateAccount = accounts.items[index]
                break
            }
        }
        
        self.accounts = accounts
        
        return updateAccount
    }
    
    // MARK: - Delete account
    
    func deleteAccount(id: Int, result: Result<Bool, Error>) throws {
        switch result {
        case .success(let isDelete):
            if isDelete {
                do {
                    try self.delete(id)
                } catch let error {
                    throw error
                }
            }
        case .failure(let error):
            throw error
        }
    }
    
    private func delete(_ id: Int) throws {
        guard var accounts = accounts else { throw CommonError.unwrappingError(#fileID, #line) }
        
        for (index, account) in accounts.items.enumerated() {
            if account.id == id {
                accounts.items.remove(at: index)
                break
            }
        }
        
        self.accounts = accounts
    }
}
