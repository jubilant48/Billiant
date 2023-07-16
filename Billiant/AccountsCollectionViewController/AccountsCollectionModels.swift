//
//  AccountsCollectionModels.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Accounts collections

enum AccountsCollection {
    enum Model {
        
        // MARK: - Request
        
        struct Request {
            enum RequestType {
                case next
                case refresh
                case create(title: String, startAmount: String)
                case update(_ id: Int, title: String, startAmount: String)
                case delete(_ id: Int, indexPath: IndexPath)
            }
        }
        
        // MARK: - Response
        
        struct Response {
            enum ResponseType {
                case presentNext(accounts: Accounts)
                case presentRefresh(accounts: Accounts)
//                case presentUpdate(account: Account)
                case presentDelete(_ id: Int, indexPath: IndexPath)
                case presentError(_ error: Error)
            }
        }
        
        // MARK: - ViewModel
        
        struct ViewModel {
            enum ViewModelData {
                case displayViewModel(_ viewModel: AccountsViewModel)
                case displayDelete(_ cells: [AccountsViewModel.Cell], indexPath: IndexPath)
                case display(error: Error)
            }
        }
        
    }
}

// MARK: - Accounts view model

struct AccountsViewModel {
    // MARK: - Enumeration
    
    enum Section: Hashable {
        case accounts
    }
    
    // MARK: - Cell
    
    struct Cell: Hashable, AccountCellViewModel {
        var title: String
        var amount: String
        
        var id: Int
        var startAmaount: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: Cell, rhs: Cell) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    // MARK: - Properties
    
    var title: String { "Счета" }
    var cells: [Cell]
    let sections: [Section] = [.accounts]
}


