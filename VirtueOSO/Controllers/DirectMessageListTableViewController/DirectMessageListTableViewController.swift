//
//  DirectMessageTableViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - DirectMessageListTableViewController

class DirectMessageListTableViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private weak var coordinator: EventsCoordinator?
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(sfSymbol: .chevronLeft, style: .plain, target: self, action: #selector(handleGoBack))
    }()
    
    private(set) lazy var rightBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            sfSymbol: .squareAndPencil,
            style: .plain,
            target: self,
            action: nil
        )
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.keyboardDismissMode = .onDrag
        view.delegate = self
        view.dataSource = self
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        view.register(SearchBarTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: SearchBarTableViewHeaderFooterView.reuseIdentifier)
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.title = "hprieto"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Init
    
    init(coordinator: EventsCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UITableViewDelegate

extension DirectMessageListTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigate(to: .directMessage)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: SearchBarTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchBarTableViewHeaderFooterView.reuseIdentifier) as! SearchBarTableViewHeaderFooterView
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as! ProfileTableViewCell
        cell.titleLabel.text = "Kanye West"
        cell.descriptionLabel.text = "Artist"
        cell.profileImageView.setTestImage()
        cell.roundProfileImageViewCorners()
        return cell
    }
}
