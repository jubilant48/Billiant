//
//  AccountsCollectionRouter.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol AccountsCollectionRoutingLogic { }

// MARK: - Accounts collection router

final class AccountsCollectionRouter: NSObject, AccountsCollectionRoutingLogic {
    // MARK: - Properties
    
    weak var viewController: AccountsCollectionViewController?

}
