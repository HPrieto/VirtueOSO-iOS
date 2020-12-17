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
    
    // MARK: - Constants
    
    private let eventsTableViewKeyPath: String = "contentSize"
    
    // MARK: - Private Properties
    
    private(set) var coordinator: ProfileCoordinator
    
    private var eventsTableViewHeightLayoutConstraint: NSLayoutConstraint?
    
    private var navigationBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? 0
    }
    
    private let leftMarginConstant: CGFloat = 20
    private var rightMarginConstant: CGFloat {
        -leftMarginConstant
    }
    
    private let barButtonItemHeightWidth: CGFloat = 35
    private var barButtonItemCornerRadius: CGFloat {
        barButtonItemHeightWidth / 2
    }
    
    private var profileImageViewMinHeight: CGFloat {
        view.frame.width
    }
    
    private var profileImageViewHeightLayoutConstraint: NSLayoutConstraint?
    
    private var profileImageViewWidth: CGFloat {
        view.frame.width - 40
    }
    
    // MARK: - Subviews
    
    private(set) lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.automaticallyAdjustsScrollIndicatorInsets = true
        view.contentInsetAdjustmentBehavior = .never
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.contentInset = UIEdgeInsets(top: profileImageViewMinHeight, left: 0, bottom: 80, right: 0)
        view.delegate = self
        return view
    }()
    
    private(set) lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        button.addShadow(radius: 5)
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
        button.addShadow(radius: 5)
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.setTestImage()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var profileNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .bold, size: 46)
        view.textColor = .white
        view.backgroundColor = .clear
        view.text = "Heriberto Prieto"
        view.numberOfLines = 1
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var profileActionView: ProfileActionView = {
        let view = ProfileActionView()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleFollowMgmt))
        view.labelStackView.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private(set) lazy var tableView: EventDetailTableView = {
        let view = EventDetailTableView()
        view.generateTestData()
        view.reloadData()
        view.isScrollEnabled = false
        
        eventsTableViewHeightLayoutConstraint = view.heightAnchor.constraint(equalToConstant: 0)
        eventsTableViewHeightLayoutConstraint?.isActive = true
        return view
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
        self.coordinator.navigate(to: .editProfile)
    }
    
    @objc private func handleFollowMgmt() {
        navigationController?.pushViewController(FollowMgmtViewController(), animated: true)
    }
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        navigationItem.leftBarButtonItem = editBarButtonItem
        
        view.addSubview(profileImageView)
        view.addSubview(profileNameLabel)
        view.addSubview(mainScrollView)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        profileImageViewHeightLayoutConstraint = profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewMinHeight)
        profileImageViewHeightLayoutConstraint?.isActive = true
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        
        mainStackView.addArrangedSubview(profileActionView)
        mainStackView.addArrangedSubview(tableView)
        
        profileNameLabel.bottomAnchor.constraint(equalTo: profileActionView.topAnchor).isActive = true
        profileNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        profileNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
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
        
        tableView.addObserver(self, forKeyPath: eventsTableViewKeyPath, options: .new, context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tableView.removeObserver(self, forKeyPath: eventsTableViewKeyPath)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == eventsTableViewKeyPath, object is UITableView {
            guard let newSize: CGSize = change?[.newKey] as? CGSize else {
                return
            }
            eventsTableViewHeightLayoutConstraint?.constant = newSize.height
        }
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

// MARK: - UIScrollViewDelegate

extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let yAbs: CGFloat = abs(y)
        if y > 0 { return }
        
        profileImageViewHeightLayoutConstraint?.constant = max(profileImageViewMinHeight, yAbs)
    }
}
