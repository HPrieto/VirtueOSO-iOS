//
//  EditProfileViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/17/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var imageViewHeight: CGFloat {
        return view.frame.height * 0.3
    }
    
    private let cameraButtonViewHeight: CGFloat = 30
    
    private var cameraButtonViewWidth: CGFloat {
        return cameraButtonViewHeight
    }
    
    private let cameraButtonRightMarginConstant: CGFloat = -20
    
    private let cameraButtonBottomMarginConstant: CGFloat = -20
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        UIBarButtonItem(
            sfSymbol: .xMark,
            style: .done,
            target: self,
            action: #selector(handleClose)
        )
    }()
    
    private(set) lazy var rightBarButtonItem: UIBarButtonItem = {
        UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(handleSave)
        )
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var cameraButton: UIImageView = {
        let view = UIImageView(sfSymbol: .camera, weight: .regular)
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var usernameTextField: SettingsCellTextFieldView = {
        SettingsCellTextFieldView(
            title: "Username",
            placeholder: "What's your username?",
            keyboardType: .emailAddress
        )
    }()
    
    private(set) lazy var bioTextField: SettingsCellTextView = {
        let view = SettingsCellTextView(
            title: "Bio",
            placeholder: "Tell the world a little about yourself",
            keyboardType: .default
        )
        return view
    }()
    
    // MARK: - Controllers
    
    private(set) lazy var cameraSelectAlertController: UIAlertController = {
        let controller = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        controller.addAction(
            UIAlertAction(
                title: "Take Photo",
                style: .default,
                handler: handleTakePhoto(action:)
            )
        )
        controller.addAction(
            UIAlertAction(
                title: "Choose Photo",
                style: .default,
                handler: handleChoosePhoto(action:)
            )
        )
        controller.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
        )
        return controller
    }()
    
    // MARK: - Handlers
    
    @objc private func handleTakePhoto(action: UIAlertAction) -> Void {
        
    }
    
    @objc private func handleChoosePhoto(action: UIAlertAction) {
        
    }
    
    @objc private func handleSelectPicture() {
        navigationController?.present(cameraSelectAlertController, animated: true, completion: nil)
    }
    
    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.2)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(cameraButton)
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(bioTextField)
        
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        
        cameraButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: cameraButtonRightMarginConstant).isActive = true
        cameraButton.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: cameraButtonBottomMarginConstant).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: cameraButtonViewHeight).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: cameraButtonViewWidth).isActive = true
        
        usernameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        bioTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor).isActive = true
        bioTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        bioTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        usernameTextField.textField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.scrollToTop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = ._black
        navigationItem.title = "Edit Profile"
    }
}
