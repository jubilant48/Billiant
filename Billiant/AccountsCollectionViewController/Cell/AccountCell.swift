//
//  AccountCell.swift
//  Billiant
//
//  Created by macbook on 21.05.2023.
//

import UIKit

// MARK: - Class

final class AccountCell: UICollectionViewCell {
    // MARK: - Properties
    
    let lineView = UIView()
    let amontLabel = UILabel(text: "50 000.00", font: .getGeezaProBold20())
    let titleLabel = UILabel(text: "Tinkoff Bank", font: .getGeezaProRegular14())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .getBlack()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        customizeElements()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func customizeElements() {
        // Configure lineView
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .getYellow()
        
        // Configure amountLabel
        amontLabel.translatesAutoresizingMaskIntoConstraints = false
        amontLabel.textColor = .getWhite()
        
        // Configure titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .getYellow()
        
    }
}

// MARK: - Setup constraints

extension AccountCell {
    private func setupConstraints() {
        // Adding subviews
        addSubview(lineView)
        addSubview(amontLabel)
        addSubview(titleLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: self.topAnchor),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        NSLayoutConstraint.activate([
            amontLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            amontLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            amontLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            amontLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}

// MARK: - Configure cell

extension AccountCell: ConfigureCell {
    // MARK: - Properties
    
    static var reuseId: String { "AccountCell" }
    
    // MARK: - Method
    
    func configure<U: Hashable>(with value: U) throws {
        guard let account: AccountsViewModel.Cell = value as? AccountsViewModel.Cell else {
            throw CommonError.castingError(#fileID, #line)
        }
                
        amontLabel.text = account.amount
        titleLabel.text = account.title
    }
}
