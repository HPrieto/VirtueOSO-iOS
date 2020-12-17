//
//  DirectMessageSettingsViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/22/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DirectMessageSettingsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: ProfileViewModel
    
    private var followersTableViewHeightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            sfSymbol: .chevronLeft,
            style: .plain,
            target: self,
            action: #selector(handleGoBack)
        )
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentInset = UIEdgeInsets(
            top: 15,
            left: 0,
            bottom: 0,
            right: 0
        )
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var muteMessagesSwitchView: SwitchView = {
        let view = SwitchView()
        view.titleLabel.text = "Mute Messages"
        return view
    }()
    
    private(set) lazy var blockSwitchView: SwitchView = {
        let view = SwitchView()
        view.titleLabel.text = "Block"
        return view
    }()
    
    private(set) lazy var followProfileView: FollowProfileView = {
        let view = FollowProfileView()
        view.usernameLabel.text = "HPrieto"
        view.nameLabel.text = "Heriberto Prieto"
        view.state = .following
        view.profileImageView.setTestImage()
        return view
    }()
    
    private(set) lazy var followersTableView: UITableView = {
        let view = UITableView(
            frame: .zero,
            style: .grouped
        )
        view.separatorStyle = .none
        view.isScrollEnabled = false
        view.backgroundColor = .white
        
        view.delegate = self
        view.dataSource = self
        view.register(TitleTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier)
        view.register(FollowProfileTableViewCell.self, forCellReuseIdentifier: FollowProfileTableViewCell.reuseIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Utils
    
    public func setFollowersTableHeight(_ height: CGFloat) {
        followersTableViewHeightLayoutConstraint?.constant = height
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.title = "Details"
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(followersTableView)
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.addArrangedSubviews([
            muteMessagesSwitchView,
            blockSwitchView,
            followersTableView
        ])
        
        followersTableViewHeightLayoutConstraint = followersTableView.heightAnchor.constraint(equalToConstant: 0)
        followersTableViewHeightLayoutConstraint?.isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.followersTableView.addObserver(
            self,
            forKeyPath: "contentSize",
            options: .new,
            context: nil
        )
        followersTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.followersTableView.removeObserver(
            self,
            forKeyPath: "contentSize"
        )
    }
    
    // MARK: - Observers
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "contentSize":
            if let newSize: CGSize = change?[.newKey] as? CGSize {
                self.setFollowersTableHeight(newSize.height)
            }
        default:
            break
        }
    }
    
    // MARK: - Init
    
    init() {
        self.viewModel = ProfileViewModel(withNTestModels: 4)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate

extension DirectMessageSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TitleTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier) as! TitleTableViewHeaderFooterView
        header.titleLabel.text = "Members"
        header.titleLabel.font = UIFont(type: .demiBold, size: 16)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowProfileTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: FollowProfileTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! FollowProfileTableViewCell
        let model: Profile = viewModel.models[indexPath.row]
        cell.usernameLabel.text = model.username
        cell.nameLabel.text = "\(model.firstname) \(model.lastname)"
        cell.state = .following
        return cell
    }
}
