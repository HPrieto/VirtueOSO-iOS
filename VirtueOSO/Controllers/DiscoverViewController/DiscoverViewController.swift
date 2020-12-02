//
//  DiscoverViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel: DiscoverProfilesViewModel
    
    private let tableViewCellHeight: CGFloat = 70
    private var tableViewCellProfileImageViewCornerRadius: CGFloat {
        let profileImageViewHeight: CGFloat = tableViewCellHeight - 20
        return profileImageViewHeight / 2
    }
    
    // MARK: - Public Properties
    
    private(set) var coordinator: DiscoverCoordinator
    
    // MARK: - Subviews
    
    private(set) lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.delegate = self
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        view.delegate = self
        view.dataSource = self
        view.register(TitleTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier)
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var rightBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            title: "Cancel",
            fontType: .demiBold,
            size: 18,
            target: self,
            action: #selector(handleDismissSearchBar)
        )
    }()
    
    // MARK: - Handlers
    
    @objc private func handleDismissSearchBar() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        tableView.scrollToTop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Init
    
    init(coordinator: DiscoverCoordinator) {
        self.coordinator = coordinator
        self.viewModel = DiscoverProfilesViewModel(withNTestModels: 20)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UISearchBarDelegate

extension DiscoverViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Begin:", searchBar.text ?? "")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("End:", searchBar.text ?? "")
    }
}

// MARK: - UITableViewDelegate

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.recentModels.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !viewModel.recentModels.isEmpty else {
            return viewModel.models.count
        }
        return section == 0 ? viewModel.recentModels.count : viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TitleTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier
        ) as! TitleTableViewHeaderFooterView
        if viewModel.recentModels.isEmpty {
            header.titleLabel.text = "Accounts"
        } else {
            header.titleLabel.text = section == 0 ? "Recent" : "Accounts"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! ProfileTableViewCell
        if viewModel.recentModels.isEmpty {
            let model: Profile = viewModel.models[indexPath.row]
            cell.usernameLabel.text = model.username
            cell.nameLabel.text = "\(model.firstname) \(model.lastname)"
            cell.roundProfileImageViewCorners()
            cell.state = .normal
        } else if indexPath.section == 0 {
            let model: Profile = viewModel.recentModels[indexPath.row]
            cell.usernameLabel.text = model.username
            cell.nameLabel.text = "\(model.firstname) \(model.lastname)"
            cell.roundProfileImageViewCorners()
            cell.state = .previouslySearched
        } else if indexPath.section == 1 {
            let model: Profile = viewModel.models[indexPath.row]
            cell.usernameLabel.text = model.username
            cell.nameLabel.text = "\(model.firstname) \(model.lastname)"
            cell.roundProfileImageViewCorners()
            cell.state = .normal
        }
        cell.profileImageView.setTestImage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.navigate(to: .artist)
    }
}
