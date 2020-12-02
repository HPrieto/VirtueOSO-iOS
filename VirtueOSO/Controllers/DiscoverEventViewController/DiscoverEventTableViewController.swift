//
//  DiscoverEventTableViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/8/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DiscoverEventViewController: UIViewController {
    
    // MARK: - Private Properties
    
    // MARK: - Public Properties
    
    private(set) var coordinator: EventsCoordinator
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        let view = UIBarButtonItem(sfSymbol: .magnifyingGlass, style: .plain, target: self, action: nil)
        return view
    }()
    
    private(set) lazy var rightBarButtonItem: UIBarButtonItem? = {
        let view = UIBarButtonItem(sfSymbol: .paperPlane, style: .plain, target: self, action: #selector(handleDirectMessages))
        return view
    }()
    
    private(set) lazy var tableView: EventTableView = {
        let view = EventTableView()
        view.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        view.generateTestData()
        view.reloadData()
        view.eventDelegate = self
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleDirectMessages() {
        coordinator.navigate(to: .directMessages)
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.title = "Virtuoso"
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
        tabBarController?.tabBar.isHidden = false
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

// MARK: - EventTableViewDelegate
extension DiscoverEventViewController: EventTableViewDelegate {
    func eventTableView(_ eventTableView: EventTableView, didSelectRowAt indexPath: IndexPath) {
        print("DiscoverEventTableViewController: ", indexPath.row)
    }
    
    func eventTableView(_ eventTableView: EventTableView, cell: EventTableViewCell, cellForRowAt indexPath: IndexPath) {
        cell.eventNameLabel.text = "Yeezus Tour 2020"
        cell.usernameLabel.text = "Kanye West"
        cell.descriptionLabel.text = "The Yeezus Tour was a concert tour by American rapper Kanye West in support of West's sixth solo studio album."
        cell.amountLabel.attributedText = NSMutableAttributedString(attributedStrings: [
            NSAttributedString(string: "$1", color: .black, fontType: .demiBold, fontSize: .small),
            NSAttributedString(string: " / person", color: ._darkGray, fontType: .medium, fontSize: .small)
        ])
        if indexPath.row % 2 == 0 {
            cell.statusTextView.text = "Live"
            cell.statusTextView.backgroundColor = UIColor._secondary
            cell.statusTextView.textColor = .white
            cell.statusTextView.addShadow()
        } else {
            //cell.statusTextView.text = "Thurs 12/1 @ 12pm"
            cell.statusTextView.text = Date().toString(withDateFormat: "EEE MM/dd @ HHa")
            cell.statusTextView.backgroundColor = ._lightGray
            cell.statusTextView.textColor = .black
            cell.statusTextView.addShadow()
        }
    }
    
    func eventTableView(_ eventTableView: EventTableView, header: TitleTableViewHeaderFooterView, viewForHeaderInSection section: Int) {
        header.titleLabel.font = UIFont(type: .demiBold, size: 21)
    }
}
