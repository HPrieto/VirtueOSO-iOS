//
//  ProfileViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: ProfileViewController
class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private(set) var coordinator: ProfileCoordinator
    
    // MARK: - Subviews
    
    private(set) lazy var rightBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(
            image: UIImage(sfSymbol: .lineHorizontal3),
            style: .plain,
            target: self,
            action: #selector(handleOpenSettings))
        return view
    }()
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(
            image: UIImage(sfSymbol: .plus),
            style: .plain,
            target: self,
            action: #selector(handleAdd))
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleOpenSettings() {
        coordinator.navigate(to: .settings)
    }
    
    @objc private func handleAdd() {
        print("Adding something...")
    }
    
    // MARK: - Initialize Subviews
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.title = "hprieto"
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Init
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
