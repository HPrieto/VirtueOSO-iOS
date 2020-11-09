//
//  ArtistViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/9/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: ArtistViewController
class ArtistViewController: UIViewController {
    
    enum State {
        case user
        case following
        case notFollowing
    }
    
    enum Strings: String, CodingKey {
        case follow = "Follow"
        case following = "Following"
    }
    
    // MARK: - Private Properties
    
    private(set) var coordinator: DiscoverCoordinator
    
    private var navigationBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? 0
    }
    
    private var profileImageViewHeight: CGFloat {
        view.frame.width * (6/9)
    }
    private let leftMarginConstant: CGFloat = 20
    private var rightMarginConstant: CGFloat {
        return -leftMarginConstant
    }
    private let barButtonItemHeightWidth: CGFloat = 35
    private var barButtonItemCornerRadius: CGFloat {
        barButtonItemHeightWidth / 2
    }
    
    // MARK: - Public Properties
    
    public lazy var sections: [String] = [
        "Live",
        "Upcoming",
        "New Releases",
        "Past Events"
    ]
    
    var state: State = .user {
        didSet {
            switch state {
            case .following:
                // Follow Button
                followButton.backgroundColor = .clear
                followButton.setTitleColor(._black, for: .normal)
                followButton.layer.borderColor = UIColor._lightGray.cgColor
                followButton.alpha = 1
                followButton.setTitle(Strings.following.rawValue, for: .normal)
            case .notFollowing:
                
                // Follow Button
                followButton.backgroundColor = ._blue
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderColor = UIColor._blue.cgColor
                followButton.alpha = 1
                followButton.setTitle(Strings.follow.rawValue, for: .normal)
            default:
                followButton.alpha = 0
            }
        }
    }
    
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
        let button = UIButton(sfSymbol: .chevronLeft)
        button.backgroundColor = .white
        button.tintColor = ._black
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.layer.cornerRadius = barButtonItemCornerRadius
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.setTestImage()
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
    
    private(set) lazy var moreButton: UIButton = {
        let view = UIButton(sfSymbol: .ellipses)
        view.tintColor = ._gray
        view.backgroundColor = .clear
        view.setImage(UIImage(sfSymbol: .ellipses), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.register(TitleTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier)
        view.register(EventDetailTableViewCell.self, forCellReuseIdentifier: EventDetailTableViewCell.reuseIdentifier)
        return view
    }()
    
    // MARK: - ViewControllers
    
    private(set) lazy var eventViewController: EventViewController = {
        let controller = EventViewController()
        return controller
    }()
    
    // MARK: - Handlers
    
    @objc private func handleOpenSettings() {
        
    }
    
    @objc private func handleGoBack() {
        coordinator.navigate(to: .artistToRoot)
    }
    
    @objc private func handleFollowButtonToggle() {
        switch self.state {
        case .following:
            state = .notFollowing
        default:
            state = .following
        }
    }
    
    @objc private func handleMore() {
        print("Showing More.")
    }
    
    // MARK: - Initialize Subviews
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(profileImageView)
        view.addSubview(profileNameLabel)
        view.addSubview(subscriberCountLabel)
        view.addSubview(followButton)
        view.addSubview(moreButton)
        view.addSubview(tableView)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        
        profileNameLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        profileNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftMarginConstant).isActive = true
        profileNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightMarginConstant).isActive = true
        profileNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        subscriberCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscriberCountLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        subscriberCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftMarginConstant).isActive = true
        subscriberCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightMarginConstant).isActive = true
        
        followButton.topAnchor.constraint(equalTo: subscriberCountLabel.bottomAnchor, constant: 10).isActive = true
        followButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        moreButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        moreButton.heightAnchor.constraint(equalTo: followButton.heightAnchor).isActive = true
        moreButton.centerYAnchor.constraint(equalTo: followButton.centerYAnchor).isActive = true
        moreButton.leftAnchor.constraint(equalTo: followButton.rightAnchor, constant: 10).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
    init(coordinator: DiscoverCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate
extension ArtistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TitleTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier) as! TitleTableViewHeaderFooterView
        header.titleLabel.text = sections[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: EventDetailTableViewCell.reuseIdentifier) as! EventDetailTableViewCell
        cell.titleLabel.text = "TEST_TITLE #119 - FA/HOCKEY, Kareem Campbell"
        cell.nameLabel.text = "Kanye West"
        cell.descriptionLabel.text = "We discuss the FA/Hockey 'Dancing On Thin Ice Vide', Anderson Cooper talks with Tony Hawk | We discuss the FA/Hockey 'Dancing On Thin Ice Vide', Anderson Cooper talks with Tony Hawk"
        cell.timestampLabel.text = "October 14, 2020 7:00 PM · 1hr 30min"
        cell.handleTitleButtonTapped = { button in
            print("button tapped: \(indexPath)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController: UINavigationController = UINavigationController(rootViewController: eventViewController)
        present(navController, animated: true, completion: nil)
    }
    
}
