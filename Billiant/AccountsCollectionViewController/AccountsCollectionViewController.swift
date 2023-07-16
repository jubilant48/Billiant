//
//  AccountsCollectionViewController.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol AccountsCollectionDisplayLogic: AnyObject {
    func displayData(viewModel: AccountsCollection.Model.ViewModel.ViewModelData)
}

// MARK: - Accounts collection view

final class AccountsCollectionViewController: UIViewController, AccountsCollectionDisplayLogic {
    // MARK: - Outletes
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var interactor: AccountsCollectionBusinessLogic?
    var router: (NSObjectProtocol & AccountsCollectionRoutingLogic)?
    
    private var viewModel: AccountsViewModel = AccountsViewModel(cells: [])
    private var dataSource: UICollectionViewDiffableDataSource<AccountsViewModel.Section, AccountsViewModel.Cell>!
    
    private lazy var accountAlert: AccountAlert = {
        let accountAlert: AccountAlert = AccountAlert.loadFromNib()
        accountAlert.center = view.center
        accountAlert.delegate = self
        
        return accountAlert
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = AccountsCollectionInteractor()
        let presenter = AccountsCollectionPresenter()
        let router = AccountsCollectionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.makeRequest(request: .next)
        
        updateUI()
        collectionView.delegate = self
        collectionView.register(AccountCell.self, forCellWithReuseIdentifier: AccountCell.reuseId)
        collectionView.collectionViewLayout = createLayout()
        
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBlur()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Methods
    
    func displayData(viewModel: AccountsCollection.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayViewModel(let viewModel):
            AnimationHelper.anumateOut(accountAlert, controller: self)
            
            self.viewModel = viewModel
            self.reloadData()
        case .displayDelete(let cells, let indexPath):
            self.viewModel.cells = cells
            deleteData(indexPath: indexPath)
        case .display(error: let error):            
            self.showErrorAlert(description: error.localizedDescription)
        }
    }
}

// MARK: - Actions

extension AccountsCollectionViewController {
    @objc func keyboardWillAppear(notification: NSNotification) {
        let standartY = view.center.y - (accountAlert.frame.height / 2)
        let nowY = accountAlert.frame.minY
                
        guard standartY == nowY else { return }
            
        UIView.animate(withDuration: 0.15) {
            self.accountAlert.transform = CGAffineTransform(translationX: 0, y: -90)
        }
    }
    
    @objc private func keyboardDisappear(notification: NSNotification) {
        UIView.animate(withDuration: 0.15) {
            self.accountAlert.transform = .identity
        }
    }
    
    @objc private func addAction() {
        if accountAlert.state.state != .create {
            accountAlert.turnCreate()
        }
        
        AnimationHelper.animateIn(accountAlert, controller: self)
        view.addSubview(accountAlert)
    }
}

// MARK: - Update UI

extension AccountsCollectionViewController {
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<AccountsViewModel.Section, AccountsViewModel.Cell>()
        
        snapshot.appendSections([.accounts])
        snapshot.appendItems(viewModel.cells, toSection: .accounts)
        
        snapshot.reloadItems(viewModel.cells)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteData(indexPath: IndexPath) {
        guard let deleteItem = dataSource.itemIdentifier(for: indexPath) else {
            self.showErrorAlert(description: "Unwrapping error in file \(#filePath) to line \(#line)")
            return
        }
        
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([deleteItem])
        
        dataSource.apply(snapshot)
    }
    
    private func setupBlur() {
        view.addSubview(visualEffectView)
        
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        visualEffectView.alpha = 0
    }
        
    private func updateNavigationItem() {
        navigationItem.title = viewModel.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        navigationItem.rightBarButtonItem?.tintColor = .get(color: ._333333_FFE600)
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(addAction)
    }
    
    private func updateUI() {
        updateNavigationItem()
        
        collectionView.backgroundColor = .get(color: ._FFFFFF_4F4F4F)
    }
}

// MARK: - Collection view delegate

extension AccountsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let item = self.dataSource.itemIdentifier(for: indexPath)!
            
            let updateImage = UIImage(systemName: "square.and.pencil")
            let updateButton = UIAction(title: "Изменить", image: updateImage) { [weak self] action in
                if self?.accountAlert.state.state != .update {
                    self?.accountAlert.turnUpdate()
                }
                
                self?.accountAlert.set(id: item.id, name: item.title, amount: item.startAmaount)
                
                self?.view.addSubview(self!.accountAlert)
                AnimationHelper.animateIn(self!.accountAlert, controller: self!)
            }
            
            let deleteImage = UIImage(systemName: "trash")
            let deleteButton = UIAction(title: "Удалить", image: deleteImage, attributes: .destructive) { [weak self] action in
                self?.interactor?.makeRequest(request: .delete(item.id, indexPath: indexPath))
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [updateButton, deleteButton])
        }
        
        return config
    }
}

// MARK: - Compositional layout

extension AccountsCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            let section = self.viewModel.sections[sectionIndex]
            
            switch section {
            case .accounts:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
                
                return section
            }
        }
        
        return layout
    }
}

// MARK: - Diffable data source

extension AccountsCollectionViewController {
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, account in
            let section = self.viewModel.sections[indexPath.section]
            
            switch section {
            case .accounts:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountCell.reuseId, for: indexPath) as! AccountCell
                
                do {
                    try cell.configure(with: self.viewModel.cells[indexPath.row])
                } catch let error {
                    self.showErrorAlert(description: error.localizedDescription)
                }
                
                return cell
            }
        }
    }
}

// MARK: - Account alert delegate

extension AccountsCollectionViewController: AccountAlertDelegate {
    func cancelAction() {
        AnimationHelper.anumateOut(accountAlert, controller: self)
    }
    
    func createAction() {
        AnimationHelper.anumateOut(accountAlert, controller: self)
        
        self.interactor?.makeRequest(request: .create(title: accountAlert.title, startAmount: accountAlert.amount))
    }
    
    func updateAction() {
        AnimationHelper.anumateOut(accountAlert, controller: self)
        
        self.interactor?.makeRequest(request: .update(accountAlert.id, title: accountAlert.title, startAmount: accountAlert.amount))
    }
}
