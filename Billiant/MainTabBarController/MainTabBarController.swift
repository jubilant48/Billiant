//
//  MainTabBarController.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit

// MARK: - Main tab bar controller

final class MainTabBarController: UITabBarController {
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        UIApplication.shared.statusBarUIView?.backgroundColor = .get(color: ._FFE600_1E1E1E)
        tabBar.tintColor = .getYellow()
        tabBar.backgroundColor = .getBlack()
        
        guard let accountsCollectionViewController = UIStoryboard(name: "AccountsCollectionViewController", bundle: nil).instantiateInitialViewController() as? AccountsCollectionViewController else { fatalError("Error 3 test") }
        
        viewControllers = [
            generateNavigationController(rootViewController: accountsCollectionViewController, title: .accounts, image: .accounts)
        ]
        
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: MainTabBarService.BarTitle, image: MainTabBarService.IconBarName) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.get(color: ._333333_FFE600)]
        navigationController.navigationBar.barTintColor = .get(color: ._FFE600_1E1E1E)
        navigationController.navigationBar.backgroundColor = .get(color: ._FFE600_1E1E1E)
        
        navigationController.tabBarItem.title = title.rawValue
        navigationController.tabBarItem.image = UIImage(named: image.rawValue)
        
        return navigationController
    }
}
