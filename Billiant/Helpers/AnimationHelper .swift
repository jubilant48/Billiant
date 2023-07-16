//
//  AnimationHelper .swift
//  Billiant
//
//  Created by macbook on 16.07.2023.
//

import UIKit

// MARK: - Class

final class AnimationHelper {}

// MARK: - Accounts Collection View Controller

extension AnimationHelper {
    static func animateIn(_ alert: AccountAlert, controller: AccountsCollectionViewController) {
        alert.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        alert.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            controller.navigationController?.navigationBar.alpha = 0.1
            controller.navigationItem.rightBarButtonItem?.isEnabled = false
            
            controller.tabBarController?.tabBar.alpha = 0.1
            controller.tabBarController?.tabBar.isUserInteractionEnabled = false
            
            controller.visualEffectView.alpha = 1
            alert.alpha = 1
            alert.transform = CGAffineTransform.identity
        }
    }
    
    static func anumateOut(_ alert: AccountAlert, controller: AccountsCollectionViewController) {
        UIView.animate(withDuration: 0.25) {
            controller.navigationController?.navigationBar.alpha = 1
            controller.navigationItem.rightBarButtonItem?.isEnabled = true
            
            controller.tabBarController?.tabBar.alpha = 1
            controller.tabBarController?.tabBar.isUserInteractionEnabled = true
            
            controller.visualEffectView.alpha = 0
            alert.alpha = 0
        } completion: { _ in
            alert.removeFromSuperview()
        }
    }
}
