//
//  PersonalInfoViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    // MARK: - PersonalInfoModel
    struct PersonalInfoModel {
        public var firstName: String
        public var lastName: String
        public var email: String
        public var phoneNumber: String
        public var addressLine1: String? = nil
        public var addressLine2: String? = nil
        public var city: String? = nil
        public var state: String? = nil
        public var zip: String? = nil
        public var createdDate: Date? = nil
        public var createdBy: Int? = nil
        public var updatedDate: Date? = nil
        public var updatedBy: Int? = nil
        
        /// Convenient way of knowing if enough personal info has been entered
        public func valid() -> Bool {
            guard firstName.count > 1,
            lastName.count > 1,
            email.count > 2,
            phoneNumber.count > 5 else {
                return false
            }
            return true
        }
        
        // MARK: - PersonalInfoModel Init
        init() {
            firstName = ""
            lastName = ""
            email = ""
            phoneNumber = ""
        }
    }
    
    enum Tags: Int {
        case none
        case firstName
        case lastName
        case email
        case phoneNumber
        case addressLine1
        case addressLine2
        case city
        case state
        case zip
    }
    
    // MARK: - Public Properties
    var personalInfo: PersonalInfoModel = PersonalInfoModel()
    let states = [
        "AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE",
        "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY",
        "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC",
        "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR",
        "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI",
        "VT", "WA", "WI", "WV", "WY"
    ]
    var _title: String? {
        didSet {
            navigationItem.title = _title
        }
    }
    
    // MARK: - Private Properties
    private var updateButtonBottomLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Views
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(sfSymbol: .arrowLeft, style: .plain, target: self, action: #selector(handleGoBack))
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = ._background
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .vertical
        view.spacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Personal Info
    private lazy var personalInfoSettingsHeaderView: SettingsHeaderCellView = {
        let view = SettingsHeaderCellView(header: "Personal Info")
        return view
    }()
    
    private lazy var firstNameTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "First Name (required)")
        view.tag = Tags.firstName.rawValue
        view.delegate = self
        return view
    }()
    
    private lazy var lastNameTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "Last Name (required)")
        view.tag = Tags.lastName.rawValue
        view.delegate = self
        return view
    }()
    
    private lazy var emailTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "Email (required)", keyboardType: .emailAddress)
        view.tag = Tags.email.rawValue
        view._keyboardType = .emailAddress
        view.delegate = self
        return view
    }()
    
    private lazy var phoneNumberTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "Phone Number (required)", placeholder: "(xxx) xxx - xxxx")
        view.tag = Tags.phoneNumber.rawValue
        view._keyboardType = .phonePad
        view.delegate = self
        return view
    }()
    
    // MARK: - Residential Address
    private lazy var residentialAddressSettingsHeaderView: SettingsHeaderCellView = {
        let view = SettingsHeaderCellView(header: "Residential Address")
        return view
    }()
    
    private lazy var addressLine1TextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "Address Line 1")
        view.tag = Tags.addressLine1.rawValue
        view.delegate = self
        return view
    }()
    
    private lazy var addressLine2TextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "Address Line 2")
        view.tag = Tags.addressLine2.rawValue
        view.delegate = self
        return view
    }()
    
    private lazy var cityStateHStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .trailing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cityTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "City")
        view.tag = Tags.city.rawValue
        view.delegate = self
        return view
    }()
    
    private lazy var statePickerView: SettingsPickerView = {
        let view = SettingsPickerView(title: "State")
        view.tag = Tags.state.rawValue
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var zipTextField: SettingsCellTextFieldView = {
        let view = SettingsCellTextFieldView(title: "Zip")
        view.tag = Tags.zip.rawValue
        view._keyboardType = .numberPad
        view.delegate = self
        return view
    }()
    
    private(set) lazy var updateButton: RoundButton = {
        let view = RoundButton("Update")
        view.disable()
        return view
    }()
    
    // MARK: - Notifications
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardNotification: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame: CGRect = keyboardNotification.cgRectValue
        updateButtonBottomLayoutConstraint?.constant = -(keyboardFrame.height + 20)
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        updateButtonBottomLayoutConstraint?.constant = -30
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
        initializeTextFields()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNameTextField.becomeFirstResponder()
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(scrollView)
        view.addSubview(updateButton)
        
        scrollView.addSubview(vStackView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        vStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        updateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        updateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        updateButtonBottomLayoutConstraint = updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.safeAreaInsets.bottom + 30))
        updateButtonBottomLayoutConstraint?.isActive = true
    }
    
    private func initializeTextFields() {
        vStackView.addArrangedSubview(personalInfoSettingsHeaderView)
        vStackView.addArrangedSubview(firstNameTextField)
        vStackView.addArrangedSubview(lastNameTextField)
        vStackView.addArrangedSubview(emailTextField)
        vStackView.addArrangedSubview(phoneNumberTextField)
        
        vStackView.addArrangedSubview(residentialAddressSettingsHeaderView)
        vStackView.addArrangedSubview(addressLine1TextField)
        vStackView.addArrangedSubview(addressLine2TextField)
        
        vStackView.addArrangedSubview(cityStateHStackView)
        cityStateHStackView.addArrangedSubview(cityTextField)
        cityStateHStackView.addArrangedSubview(statePickerView)
        cityTextField.widthAnchor.constraint(equalTo: cityStateHStackView.widthAnchor, multiplier: 0.6).isActive = true
        
        vStackView.addArrangedSubview(zipTextField)
        vStackView.addVerticalEmptySpace(view.frame.height * 0.5)
    }
    
    //MARK:- Handlers
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// User should not be allowed to enter a space for an email
        if textField.tag == Tags.email.rawValue && string == " " {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension PersonalInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == Tags.state.rawValue {
            return 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == Tags.state.rawValue {
            return states.count
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("DidSelect: \(pickerView.tag)")
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == Tags.state.rawValue {
            return self.states[row]
        }
        return nil
    }
}
