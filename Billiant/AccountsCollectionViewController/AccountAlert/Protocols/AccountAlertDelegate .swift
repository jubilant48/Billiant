//
//  AccountAlertDelegate .swift
//  Billiant
//
//  Created by macbook on 09.07.2023.
//

import UIKit

// MARK: - Protocols

protocol AccountAlertDelegate {
    func cancelAction()
    func createAction()
    func updateAction()
}
