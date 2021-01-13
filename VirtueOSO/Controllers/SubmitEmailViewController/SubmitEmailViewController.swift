//
//  SubmitEmailViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol SubmitEmailViewControllerDelegate {
    func submitEmailViewController(_ controller: SubmitEmailViewController, didSubmitEmail email: String)
}

// MARK: - SubmitEmailViewController
class SubmitEmailViewController: UIViewController {
    
    enum State {
        case enabled
        case disabled
    }
    
    enum SubviewTags: Int {
        case emailTextField
    }
    
    // MARK: - Public Properties
    
    var delegate: SubmitEmailViewControllerDelegate?
    
    var _state: State = .disabled {
        didSet {
            switch _state {
            case .disabled:
                submitButton.backgroundColor = ._lightGray
                submitButton.isEnabled = false
            case .enabled:
                submitButton.backgroundColor = ._black
                submitButton.isEnabled = true
            }
        }
    }
    
    var _message: String = "" {
        didSet {
            messageTextView.text = _message
        }
    }
    
    var _title: String = "" {
        didSet {
            emailTextField._title = _title
        }
    }
    
    var _text: String = "" {
        didSet {
            emailTextField._text = _text
        }
    }
    
    var _submitButtonText: String = "" {
        didSet {
            submitButton.setTitle(_submitButtonText, for: .normal)
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var messageTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .regular, size: 14)
        view.textColor = ._gray
        return view
    }()
    
    private(set) lazy var emailTextField: BorderedTextField = {
        let view = BorderedTextField()
        view.textField.tag = SubviewTags.emailTextField.rawValue
        view.textField.addTarget(self, action: #selector(handleEmailTextFieldValueChanged), for: .valueChanged)
        return view
    }()
    
    private(set) lazy var submitButton: Button = {
        let view = Button("", buttonType: .large)
        view.backgroundColor = ._lightGray
        view.isEnabled = false
        view.addTarget(self, action: #selector(handleSubmitEmail), for: .touchUpInside)
        return view
    }()
    
    private(set) lazy var closeBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(handleClose)
        )
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSubmitEmail(sender: UIButton) {
        guard
            let email: String = emailTextField.textField.text,
            email.count > 3
        else {
            return
        }
        delegate?.submitEmailViewController(self, didSubmitEmail: email)
    }
    
    @objc private func handleEmailTextFieldValueChanged(textField: UITextField) {
        print(textField.text)
        guard
            textField.tag == SubviewTags.emailTextField.rawValue,
            let email: String = textField.text,
            email.count > 3
        else {
            _state = .disabled
            return
        }
        _state = .enabled
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? NavigationController {
            navigationController._isClear = false
            navigationController._font = UIFont(type: .regular, size: .small)
            navigationController._tintColor = .black
            navigationController._barStyle = .default
            navigationController.navigationBar.backgroundColor = .white
        }
        emailTextField.becomeFirstResponder()
    }
    
    // MARK: - Initialize Subviews
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = closeBarButtonItem
        
        view.addSubview(messageTextView)
        view.addSubview(emailTextField)
        view.addSubview(submitButton)
        
        messageTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        messageTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Margins.width.rawValue).isActive = true
        messageTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 20).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: messageTextView.widthAnchor).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        submitButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
