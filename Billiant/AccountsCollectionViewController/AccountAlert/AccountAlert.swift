//
//  AccountAlert.swift
//  Billiant
//
//  Created by macbook on 09.07.2023.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

final class AccountAlert: UIView {    
    // MARK: - Outletes
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: MDCFilledTextField!
    @IBOutlet weak var amountTextField: MDCFilledTextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    // MARK: - Properties
    
    var delegate: AccountAlertDelegate?
    
    /// Default state is create. If you want change state, call methods `turnCreate()` or `turnUpdate()`
    var state: AccountAlertStateProtocol = CrateAccount()
    
    var id: Int = 0
    var title: String {
        return nameTextField.text ?? ""
    }
    var amount: String {
        return amountTextField.text ?? ""
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateUI()
    }
    
    // MARK: - Actions
    
    @IBAction func cancelAction(_ sender: UIButton) {
        delegate?.cancelAction()
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        switch state.state {
        case .create:
            delegate?.createAction()
        case .update:
            delegate?.updateAction()
        }
    }
    
    // MARK: - Methods
    
    func set(state: AccountAlertStateProtocol) {
        self.state = state
    }
    
    func set(id: Int?, name: String?, amount: String?) {
        if let name = name {
            nameTextField.text = name
        }
        
        if let amount = amount {
            amountTextField.text = amount
        }
        
        if let id = id {
            self.id = id
        }
    }
}

// MARK: - Update UI

extension AccountAlert {
    private func updateUI() {
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        customizeElements()
    }
    
    private func customizeElements() {
        // Customize nameTextField
        nameTextField.label.text = "Наименование"
        
        nameTextField.setNormalLabelColor(.label, for: .normal)
        nameTextField.setFloatingLabelColor(.label, for: .editing)
                
        nameTextField.setUnderlineColor(.get(color: ._FFFFFF_4F4F4F), for: .normal)
        nameTextField.setUnderlineColor(.label, for: .editing)
        
        // Customize amountTextField
        amountTextField.label.text = "Стартовая сумма"
        amountTextField.keyboardType = .numbersAndPunctuation
        
        amountTextField.setNormalLabelColor(.label, for: .normal)
        amountTextField.setFloatingLabelColor(.label, for: .editing)
        
        amountTextField.setUnderlineColor(.get(color: ._FFFFFF_4F4F4F), for: .normal)
        amountTextField.setUnderlineColor(.label, for: .editing)
        
        // Customize cancelButton
        cancelButton.layer.cornerRadius = 4
        
        // Customize acceptButton
        acceptButton.layer.cornerRadius = 4
    }
}

// MARK: - Account Alert State

extension AccountAlert {
    func turnCreate() {
        state.create(self)
    }
    
    func turnUpdate() {
        state.update(self)
    }
}


