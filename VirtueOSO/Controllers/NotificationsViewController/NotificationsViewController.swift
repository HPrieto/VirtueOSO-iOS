//
//  NotificationsViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/2/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel: NotificationViewModel
    
    // MARK: - Subviews
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        view.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.reuseIdentifier)
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Init
    
    init() {
        self.viewModel = NotificationViewModel(nTestMessages: 5, nTestFollowers: 5)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier, for: indexPath) as! NotificationTableViewCell
        return cell
    }
}
