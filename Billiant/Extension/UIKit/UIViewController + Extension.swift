//
//  UIViewController + Extension.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Extension

extension UIViewController {
    // MARK: - Methods
    
    func showErrorAlert(title: String = "Ошибка", description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "😨", style: .cancel)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
