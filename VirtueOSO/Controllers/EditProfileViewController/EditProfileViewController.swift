//
//  EditProfileViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/17/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol EditProfileViewControllerDelegate {
    func editProfileViewController(_ controller: EditProfileViewController, didSaveUsername username: String?, bio: String?, image: UIImage?)
}

class EditProfileViewController: UIViewController {
    
    enum State {
        case normal
        case updated
    }
    
    // MARK: - Private Properties
    
    private var imageViewHeight: CGFloat {
        return view.frame.height * 0.3
    }
    
    private let cameraButtonViewHeight: CGFloat = 50
    
    private var cameraButtonViewWidth: CGFloat {
        return cameraButtonViewHeight
    }
    
    private let cameraButtonRightMarginConstant: CGFloat = -10
    
    private let cameraButtonBottomMarginConstant: CGFloat = -10
    
    // MARK: - Public Properties
    
    public var _state: State = .updated {
        didSet {
            switch _state {
            case .normal:
                rightBarButtonItem.isEnabled = false
                rightBarButtonItem.tintColor = ._lightGray
            case .updated:
                rightBarButtonItem.isEnabled = true
                rightBarButtonItem.tintColor = ._black
            }
        }
    }
    
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
       let view = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(handleSave)
        )
        view.tintColor = ._lightGray
        view.isEnabled = false
        return view
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
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var cameraButton: UIButton = {
        let view = UIButton(sfSymbol: .camera, withWeight: .regular)
        view.tintColor = .white
        view.backgroundColor = .clear
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleSelectPicture), for: .touchUpInside)
        return view
    }()
    
    private(set) lazy var usernameTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(
            title: "Username",
            placeholder: "What's your username?",
            keyboardType: .emailAddress
        )
        view.textField.addTarget(self, action: #selector(handleTextFieldValueChanged), for: .valueChanged)
        return view
    }()
    
    private(set) lazy var bioTextField: SettingsCellTextView = {
        let view = SettingsCellTextView(
            title: "Bio",
            keyboardType: .default
        )
        view.textView.delegate = self
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
    
    private(set) lazy var imagePickerController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        return controller
    }()
    
    // MARK: - Handlers
    
    @objc private func handleTakePhoto(action: UIAlertAction) -> Void {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func handleChoosePhoto(action: UIAlertAction) {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func handleSelectPicture() {
        present(cameraSelectAlertController, animated: true, completion: nil)
    }
    
    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave() {
    }
    
    @objc private func handleTextFieldValueChanged(textField: UITextField) {
        guard
            let text: String = textField.text,
            text.count > 0
        else {
            return
        }
        _state = .updated
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
        _state = .normal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = ._black
        navigationItem.title = "Edit Profile"
    }
}

// MARK: - UITextViewDelegate

extension EditProfileViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard
            let text: String = textView.text,
            text.count > 0
        else {
            return
        }
        _state = .updated
    }
}

// MARK: - UIImagePickerControllerDelegate

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image: UIImage = info[.originalImage] as? UIImage {
            imageView.image = image
            _state = .updated
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
