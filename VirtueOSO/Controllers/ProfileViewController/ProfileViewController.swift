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
        return view.frame.width * (6/9)
    }
    
    private var profileImageViewWidth: CGFloat {
        return view.frame.width - 40
    }
    
    // MARK: - Subviews
    
    private(set) lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        view.automaticallyAdjustsScrollIndicatorInsets = true
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
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
        view.contentMode = .scaleAspectFill
        view.setTestImage()
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
    
    private(set) lazy var bioLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: 12)
        view.numberOfLines = 10
        view.textColor = ._gray
        // view.text = "A short message."
        view.text = "The functions and arguments are renamed in a way that, for me, clarifies what's going on, for instance by distinguishing a Swift closure from a UIButton action."
        // view.text = "The functions and arguments are renamed in a way that, for me, clarifies what's going on, for instance by distinguishing a Swift closure from a UIButton action. The functions and arguments are renamed in a way that, for me, clarifies what's going on, for instance by distinguishing a Swift closure from a UIButton action."
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var tableView: EventDetailTableView = {
        let view = EventDetailTableView()
        view.generateTestData()
        view.reloadData()
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 44
        view.isScrollEnabled = false
        view.setFixedHeight()
        return view
    }()
    
    private(set) var eventsLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            attributedStrings: [
                NSAttributedString(string: "20", color: ._black, fontType: .demiBold, fontSize: .small),
                NSAttributedString(string: "\nEvents", color: ._black, fontType: .regular, fontSize: .small),
            ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var followersLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            attributedStrings: [
                NSAttributedString(string: "1,000", color: ._black, fontType: .demiBold, fontSize: .small),
                NSAttributedString(string: "\nFollowers", color: ._black, fontType: .regular, fontSize: .small),
            ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var followingLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            attributedStrings: [
                NSAttributedString(string: "150", color: ._black, fontType: .demiBold, fontSize: .small),
                NSAttributedString(string: "\nFollowing", color: ._black, fontType: .regular, fontSize: .small),
            ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var labelStackView: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [
                eventsLabel,
                followersLabel,
                followingLabel,
            ]
        )
        view.spacing = 5
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        navigationItem.leftBarButtonItem = editBarButtonItem
        
        view.addSubview(profileImageView)
        view.addSubview(mainScrollView)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        profileImageView.addSubview(profileNameLabel)
        
        profileNameLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        profileNameLabel.widthAnchor.constraint(equalToConstant: profileImageViewWidth).isActive = true
        profileNameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        
        mainScrollView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        
        mainStackView.addArrangedSubview(labelStackView)
        mainStackView.addArrangedSubview(tableView)
        
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
