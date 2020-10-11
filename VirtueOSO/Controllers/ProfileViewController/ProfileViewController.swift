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
    
    enum Strings: String, CodingKey {
        case follow = "Follow"
        case following = "Following"
    }
    
    // MARK: - Private Properties
    
    private(set) var coordinator: ProfileCoordinator
    
    private var navigationBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? 0
    }
    
    private let leftMarginConstant: CGFloat = 20
    private var rightMarginConstant: CGFloat {
        return -leftMarginConstant
    }
    
    private let barButtonItemHeightWidth: CGFloat = 35
    private var barButtonItemCornerRadius: CGFloat {
        barButtonItemHeightWidth / 2
    }
    
    private var profileImageViewHeight: CGFloat {
        return view.frame.height * 0.4
    }
    
    private var profileImageViewWidth: CGFloat {
        return view.frame.width - 40
    }
    
    // MARK: - Subviews
    
    private(set) lazy var settingsBarButtonItem: UIBarButtonItem = {
        let button = UIButton(sfSymbol: .lineHorizontal3)
        button.backgroundColor = .white
        button.tintColor = ._black
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.layer.cornerRadius = barButtonItemCornerRadius
        button.addTarget(self, action: #selector(handleOpenSettings), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var editBarButtonItem: UIBarButtonItem = {
        let button = UIButton(sfSymbol: .squareAndPencil)
        button.backgroundColor = .white
        button.tintColor = ._black
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.layer.cornerRadius = barButtonItemCornerRadius
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var profileNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .demiBold, size: .title1)
        view.textColor = .white
        view.backgroundColor = .clear
        view.text = "Heriberto Prieto"
        view.numberOfLines = 1
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var subscriberCountLabel: UILabel = {
        let view = UILabel()
        view.text = "32,000,000 monthly viewers"
        view.backgroundColor = .clear
        view.textColor = ._gray
        view.font = UIFont(type: .medium, size: .small)
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var followButton: Button = {
        let button = Button("Follow")
        button.backgroundColor = ._blue
        button._borderWidth = 1
        button._borderColor = ._blue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleFollowButtonToggle), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Handlers
    
    @objc private func handleOpenSettings() {
        coordinator.navigate(to: .settings)
    }
    
    @objc private func handleAdd() {
        print("Adding something...")
    }
    
    @objc private func handleFollowButtonToggle() {
        print("Follow")
    }
    
    @objc private func handleEdit() {
        print("Editing")
    }
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        navigationItem.leftBarButtonItem = editBarButtonItem
        
        view.addSubview(profileImageView)
        view.addSubview(profileNameLabel)
        view.addSubview(subscriberCountLabel)
        view.addSubview(followButton)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -navigationBarHeight).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        
        profileNameLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        profileNameLabel.widthAnchor.constraint(equalToConstant: profileImageViewWidth).isActive = true
        profileNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        subscriberCountLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        subscriberCountLabel.widthAnchor.constraint(equalToConstant: profileImageViewWidth).isActive = true
        subscriberCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        followButton.topAnchor.constraint(equalTo: subscriberCountLabel.bottomAnchor, constant: 10).isActive = true
        followButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = ._black
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
