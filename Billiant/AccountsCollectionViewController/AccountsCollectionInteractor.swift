//
//  AccountsCollectionInteractor.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol AccountsCollectionBusinessLogic {
    func makeRequest(request: AccountsCollection.Model.Request.RequestType)
}

// MARK: - Acooutns collection interactor

final class AccountsCollectionInteractor: AccountsCollectionBusinessLogic {
    // MARK: - Properties
    
    var presenter: AccountsCollectionPresentationLogic?
    var service: AccountsInteractorService = AccountsCollectionService()
    
    private var networking: NetworkDataFetcher = NetworkDataFetcher()
    
    // MARK: - Methods
    
    func makeRequest(request: AccountsCollection.Model.Request.RequestType) {
        switch request {
        case .next:
            nextAccounts()
        case .refresh:
            refreshAccounts()
        case .create(let title, let startAmount):
            createAccount(title: title, startAmount: startAmount)
        case .update(let id, let title,let  startAmount):
            updateAccount(id: id, title: title, startAmount: startAmount)
        case .delete(let id, let indexPath):
            deleteAccount(id: id, indexPath: indexPath)
        }
    }
}

// MARK: - Next accounts

extension AccountsCollectionInteractor {
    private func nextAccounts() {
        do {
            try networking.accounts.next { result in
                
                do {
                    let accounts = try self.service.nextAccounts(result: result)
                    
                    self.presenter?.presentData(response: .presentNext(accounts: accounts))
                } catch let error {
                    self.present(error)
                }
                
            }
        } catch let error {
            present(error)
        }
    }
}

// MARK: - Refresh accounts

extension AccountsCollectionInteractor {
    private func refreshAccounts() {
        do {
            try networking.accounts.refresh { result in
                
                do {
                    let accounts = try self.service.refreshAccounts(result: result)
                    
                    self.presenter?.presentData(response: .presentRefresh(accounts: accounts))
                } catch let error {
                    self.present(error)
                }
                
            }
        } catch let error {
            self.present(error)
        }
    }
}

// MARK: - Create account

extension AccountsCollectionInteractor {
    private func createAccount(title: String, startAmount: String) {
        do {
            guard try Validator.validate(text: startAmount, for: .double) else { throw ValidatorError.validationError(.startAmount) }
            
            let roundedAmount = FormatterHelper.rounding(Double(startAmount)!, afterDecimalPoint: 2)
            
            try networking.account.create(title: title, startAmount: roundedAmount) { result in
                
                do {
                    try self.service.createAccount(result: result)
                    
                    self.refreshAccounts()
                } catch let error {
                    self.present(error)
                }
                
            }
        } catch let error {
            self.present(error)
        }
    }
}

// MARK: - Update account

extension AccountsCollectionInteractor {
    private func updateAccount(id: Int, title: String, startAmount: String) {
        do {
            guard try Validator.validate(text: startAmount, for: .double) else { throw ValidatorError.validationError(.startAmount) }
            
            let roundedAmount = FormatterHelper.rounding(Double(startAmount)!, afterDecimalPoint: 2)
            
            try networking.account.update(id: id, title: title, startAmount: roundedAmount) { result in
                
                do {
                    let accounts = try self.service.updateAccount(id: id, result: result, title: title, startAmount: roundedAmount)
                    
                    self.presenter?.presentData(response: .presentRefresh(accounts: accounts))
                } catch let error {
                    self.present(error)
                }
                
            }
        } catch let error {
            self.present(error)
        }
    }
}

// MARK: - Delete account

extension AccountsCollectionInteractor {
    private func deleteAccount(id: Int, indexPath: IndexPath) {
        do {
            try networking.account.delete(id: id) { result in
                
                do {
                    try self.service.deleteAccount(id: id, result: result)
                    
                    self.presenter?.presentData(response: .presentDelete(id, indexPath: indexPath))
                } catch let error {
                    self.present(error)
                }
                
            }
        } catch let error {
            self.present(error)
        }
    }
}

// MARK: - Present error

extension AccountsCollectionInteractor {
    private func present(_ error: Error) {
        self.presenter?.presentData(response: .presentError(error))
    }
}
