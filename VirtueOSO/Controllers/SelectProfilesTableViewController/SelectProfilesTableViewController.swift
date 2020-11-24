//
//  SelectProfilesTableViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/23/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SelectProfilesTableViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: ProfileViewModel
    private weak var coordinator: EventsCoordinator?
    
    // MARK: - Public Properties
    
    private(set) var selectedModels: [Profile]
    
    // MARK: - Subviews
    
    private(set) lazy var backBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            sfSymbol: .chevronLeft,
            style: .plain,
            target: self,
            action: #selector(handleGoBack)
        )
    }()
    
    private(set) lazy var toLabel: UILabel = {
        let view = UILabel()
        view.text = "To"
        view.textColor = .black
        view.font = UIFont(type: .demiBold, size: 17)
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var textField: UITextField = {
        let view = UITextField()
        view.placeholder = "Search..."
        view.font = UIFont(type: .medium, size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.backgroundColor = .white
        
        view.delegate = self
        view.dataSource = self
        view.register(TitleTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier)
        view.register(SelectProfileTableViewCell.self, forCellReuseIdentifier: SelectProfileTableViewCell.reuseIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        var leftBarButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()
        
        if let backBarButtonItem: UIBarButtonItem = backBarButtonItem {
            leftBarButtonItems.append(backBarButtonItem)
        }
        
        navigationItem.leftBarButtonItems = leftBarButtonItems
        
        view.addSubview(toLabel)
        view.addSubview(textField)
        view.addSubview(tableView)
        
        toLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        toLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        toLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        textField.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 10).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    // MARK: - Init
    
    init(coordinator: EventsCoordinator) {
        self.coordinator = coordinator
        self.selectedModels = [Profile]()
        self.viewModel = ProfileViewModel(withNTestModels: 20)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate

extension SelectProfilesTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TitleTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier
        ) as! TitleTableViewHeaderFooterView
        header.titleLabel.font = UIFont(type: .demiBold, size: 17)
        header.titleLabel.text = "Suggested"
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectProfileTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: SelectProfileTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! SelectProfileTableViewCell
        let model: Profile = viewModel.models[indexPath.row]
        cell.usernameLabel.text = model.username
        cell.nameLabel.text = "\(model.firstname) \(model.lastname)"
        cell.profileImageView.setTestImage()
        cell.selectButtonOnClick = {
            print("Button Clicked: \(indexPath.row)")
        }
        return cell
    }
    
    
}
