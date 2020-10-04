//
//  SubmitEmailViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - SubmitEmailViewController
class SubmitEmailViewController: UIViewController {
    
    // MARK: - Public Properties
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
    lazy var messageTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .regular, size: .large)
        view.textColor = ._gray
        return view
    }()
    
    lazy var emailTextField: BorderedTextField = {
        let view = BorderedTextField()
        return view
    }()
    
    lazy var submitButton: Button = {
        let view = Button()
        view.backgroundColor = ._black
        return view
    }()
    
    lazy var closeBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(handleClose)
        )
        return view
    }()
    
    // MARK: - Handlers
    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
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
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = closeBarButtonItem
        
        view.addSubview(messageTextView)
        view.addSubview(emailTextField)
        view.addSubview(submitButton)
        
        messageTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + Margins.top.rawValue).isActive = true
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
