//
//  AccountsCollectionPresenter.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol AccountsCollectionPresentationLogic {
    func presentData(response: AccountsCollection.Model.Response.ResponseType)
}

// MARK: - Accounts collection presentor

final class AccountsCollectionPresenter: AccountsCollectionPresentationLogic {
    // MARK: - Properties
    
    weak var viewController: AccountsCollectionDisplayLogic?
    var accountsViewModel: AccountsViewModel!
    
    // MARK: - Methods
    
    func presentData(response: AccountsCollection.Model.Response.ResponseType) {
        switch response {
        case .presentNext(let accounts):
            displayNext(accounts)
        case .presentRefresh(let accounts):
            displayRefresh(accounts)
        case .presentDelete(let id, let indexPath):
            displayDelete(id, indexPath: indexPath)
        case .presentError(let error):
            displayError(error)
        }
    }
    
    private func cellViewModel(from account: Account) throws -> AccountsViewModel.Cell {
        guard let amount = Double(account.amount) else {
            print("Error uwrapped amount")
            return AccountsViewModel.Cell(title: "0", amount: "0", id: 999, startAmaount: "777")
        }
        
        let amountFormat = FormatterHelper.currncyFormat(amount, format: .ru)
        
        return AccountsViewModel.Cell(title: account.title, amount: amountFormat, id: account.id, startAmaount: account.startAmount)
    }
}

// MARK: - Display next

extension AccountsCollectionPresenter {
    private func displayNext(_ accounts: Accounts) {
        do {
            let cells = try accounts.items.map { account in
                try cellViewModel(from: account)
            }
            
            self.accountsViewModel = AccountsViewModel(cells: cells)
            self.viewController?
                .displayData(viewModel: .displayViewModel(accountsViewModel))
            
        } catch let error {
            displayError(error)
        }
    }
}

// MARK: - Display refresh

extension AccountsCollectionPresenter {
    private func displayRefresh(_ accounts: Accounts) {
        do {
            let cells = try accounts.items.map { account in
                try cellViewModel(from: account)
            }
            
            try refresh(cells: cells)
            self.viewController?.displayData(viewModel: .displayViewModel(accountsViewModel))
        } catch let error {
            displayError(error)
        }
    }
    
    private func refresh(cells newCells: [AccountsViewModel.Cell]) throws {
        var cells = accountsViewModel.cells
        
        try newCells.forEach { newCell in
            if cells.contains(newCell) {
                guard let index = cells.firstIndex(of: newCell) else {
                    throw CommonError.unwrappingError(#file, #line)
                }

                cells[index] = newCell
            } else {
                cells.append(newCell)
            }
        }
        
        accountsViewModel.cells = cells
    }
}

// MARK: - Display delete

extension AccountsCollectionPresenter {
    private func displayDelete(_ id: Int, indexPath: IndexPath) {
        var cells = accountsViewModel.cells
        
        for (index, cell) in cells.enumerated() {
            if cell.id == id {
                cells.remove(at: index)
                break
            }
        }
        
        accountsViewModel.cells = cells
        
        print(cells)
        
        self.viewController?.displayData(viewModel: .displayDelete(cells, indexPath: indexPath))
    }
}

// MARK: - Display error

extension AccountsCollectionPresenter {
    private func displayError(_ error: Error) {
        self.viewController?.displayData(viewModel: .display(error: error))
    }
}
