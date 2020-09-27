//
//  ChangePasswordViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/1/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - ChangePasswordViewController
class ChangePasswordViewController: UIViewController {
    
    enum Strings: String {
        case navbarTitle = "Change Password"
        case currentPasswordTitle = "Current Password"
        case newPasswordTitle = "New Password"
        case confirmPasswordTitle = "Confirm New Password"
        case description = "At least 8 characters"
        case nextButtonTitle = "Next"
    }
    
    enum Tags: Int {
        case normal
        case currentPassword
        case newPassword
        case confirmNewPassword
    }
    
    // MARK: - Public Properties
    public var nextButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Subviews
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(sfSymbol: .arrowLeft, style: .plain, target: self, action: #selector(handleGoBack))
    }()
    
    private lazy var vStackView: StackView = {
        let view = StackView(.vertical)
        return view
    }()
    
    private lazy var currentPasswordTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: Strings.currentPasswordTitle.rawValue)
        view.tag = Tags.currentPassword.rawValue
        view._inputMode = .secure
        view.delegate = self
        return view
    }()
    
    private lazy var newPasswordTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: Strings.newPasswordTitle.rawValue)
        view.tag = Tags.newPassword.rawValue
        view._inputMode = .secure
        view.delegate = self
        return view
    }()
    
    private lazy var confirmPasswordTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: Strings.confirmPasswordTitle.rawValue)
        view.tag = Tags.confirmNewPassword.rawValue
        view._inputMode = .secure
        view.delegate = self
        return view
    }()
    
    private(set) lazy var nextButton: RoundButton = {
        let view = RoundButton("Next")
        view._state = .disabled
        return view
    }()
    
    // MARK: - Notifications
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardNotification: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame: CGRect = keyboardNotification.cgRectValue
        nextButtonBottomConstraint?.constant = -(keyboardFrame.height + 20)
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        nextButtonBottomConstraint?.constant = -30
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Utils
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentPasswordTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.title = "Change Password"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(vStackView)
        view.addSubview(nextButton)
        
        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        vStackView.addArrangedSubviews([
            currentPasswordTextField,
            newPasswordTextField,
            confirmPasswordTextField
        ])
        
        vStackView.addVerticalEmptySpace(5)
        vStackView.addToStack(
            Strings.description.rawValue,
            leftPadding: 15
        )
        
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        nextButtonBottomConstraint?.isActive = true
    }
}

// MARK: - UITextFieldDelegate
extension ChangePasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentPasswordLength: Int = currentPasswordTextField._text?.count, currentPasswordLength >= 8,
            let newPasswordLength: Int = newPasswordTextField._text?.count, newPasswordLength >= 8,
            let confirmPasswordLength: Int = confirmPasswordTextField._text?.count, confirmPasswordLength >= 8 {
            nextButton._state = .enabled
        } else {
            nextButton._state = .disabled
        }
        if string == " " {
            return false
        }
        return true
    }
}
