//
//  DirectMessageTableViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/20/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DirectMessageTableViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var sendTextFieldViewBottomLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    
    private(set) var viewModel: DirectMessageViewModel
    
    // MARK: ViewControllers
    
    private(set) lazy var directMessageSettingsViewController: DirectMessageSettingsViewController = {
        let controller = DirectMessageSettingsViewController()
        return controller
    }()
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            sfSymbol: .chevronLeft,
            style: .plain,
            target: self,
            action: #selector(handleGoBack)
        )
    }()
    
    private(set) lazy var leftBackBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            sfSymbol: .chevronLeft,
            style: .plain,
            target: self,
            action: #selector(handleGoBack)
        )
    }()
    
    private(set) lazy var leftProfileImageBarButtonItem: UIBarButtonItem? = {
        return  UIBarButtonItem(
            withRoundImage: nil,
            target: self,
            action: nil
        )
    }()
    
    private(set) lazy var leftUsernameBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            title: "Yeezy",
            fontType: .demiBold,
            size: 18,
            target: nil,
            action: nil
        )
    }()
    
    private(set) lazy var rightInfoBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            sfSymbol: .infoCircle,
            style: .plain,
            target: self,
            action: #selector(handleGoToSettings)
        )
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        view.register(TimestampTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TimestampTableViewHeaderFooterView.reuseIdentifier)
        view.register(DirectMessageTableViewCell.self, forCellReuseIdentifier: DirectMessageTableViewCell.reuseIdentifier)
        return view
    }()
    
    private(set) lazy var sendTextFieldView: SendTextFieldView = {
        let view = SendTextFieldView()
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleGoToSettings() {
        navigationController?.pushViewController(directMessageSettingsViewController, animated: true)
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        var leftBarButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()
        var rightBarButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()
        
        if let leftBackBarButtonItem = leftBackBarButtonItem {
            leftBarButtonItems.append(leftBackBarButtonItem)
        }
        
        if let leftProfileImageBarButtonItem = leftProfileImageBarButtonItem {
            leftBarButtonItems.append(leftProfileImageBarButtonItem)
        }
        
        if let leftUsernameBarButtonItem = leftUsernameBarButtonItem {
            leftBarButtonItems.append(leftUsernameBarButtonItem)
        }
        
        if let rightInfoBarButtonItem = rightInfoBarButtonItem {
            rightBarButtonItems.append(rightInfoBarButtonItem)
        }
        
        navigationItem.leftBarButtonItems = leftBarButtonItems
        
        navigationItem.rightBarButtonItems = rightBarButtonItems
        
        view.addSubview(tableView)
        view.addSubview(sendTextFieldView)
        
        sendTextFieldViewBottomLayoutConstraint = sendTextFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        sendTextFieldView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        sendTextFieldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        sendTextFieldViewBottomLayoutConstraint?.isActive = true
        
        tableView.bottomAnchor.constraint(equalTo: sendTextFieldView.centerYAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        tableView.scrollToBottom(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Keyboard Show/Hide
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardRect: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight: CGFloat = keyboardRect.height
        let bottomMargin: CGFloat = -(keyboardHeight + 10)
        setSendTextFieldViewBottomConstant(bottomMargin)
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        setSendTextFieldViewBottomConstant(-40)
    }
    
    private func setSendTextFieldViewBottomConstant(_ constant: CGFloat, withDuration duration: TimeInterval = 0.25) {
        sendTextFieldViewBottomLayoutConstraint?.constant = constant
        UIView.animate(withDuration: duration) { [weak self] in
            guard let `self` = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Init
    
    init() {
        self.viewModel = DirectMessageViewModel(withNTestModels: 4)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITableViewDelegate

extension DirectMessageTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TimestampTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TimestampTableViewHeaderFooterView.reuseIdentifier
        ) as! TimestampTableViewHeaderFooterView
        header.date = Date()
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DirectMessageTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: DirectMessageTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! DirectMessageTableViewCell
        let model: DirectMessage = viewModel.models[indexPath.row]
        cell.messageLabel.text = indexPath.row % 3 == 0 ? "Test" : model.message
        cell.state = indexPath.row % 2 == 0 ? .sent : .received
        return cell
    }
}
