//
//  ArtistViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/9/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit
import MessageUI

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
    
    private var profileImageViewHeightLayoutConstraint: NSLayoutConstraint?
    
    private var profileImageViewMinHeight: CGFloat {
        view.frame.width
    }
    
    private let leftMarginConstant: CGFloat = 20
    private var rightMarginConstant: CGFloat {
        return -leftMarginConstant
    }
    private let barButtonItemHeightWidth: CGFloat = 35
    private var barButtonItemCornerRadius: CGFloat {
        barButtonItemHeightWidth / 2
    }
    
    private var tableViewHeightLayoutConstraint: NSLayoutConstraint?
    
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
                actionView.state = .following
            case .notFollowing:
                
                // Follow Button
                actionView.state = .follow
            default:
                actionView.alpha = 0
            }
        }
    }
    
    // MARK: - Controllers
    
    private(set) lazy var emailComposeViewController: MFMailComposeViewController = {
        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = self
        return controller
    }()
    
    private(set) lazy var directMessageViewController: DirectMessageTableViewController = {
        let controller = DirectMessageTableViewController()
        return controller
    }()
    
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
        button.addShadow()
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentInsetAdjustmentBehavior = .never
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: profileImageViewMinHeight, left: 0, bottom: 80, right: 0)
        
        view.delegate = self
        return view
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.font = UIFont(type: .bold, size: 46)
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
    
    private(set) lazy var actionView: ArtistActionView = {
        let view = ArtistActionView()
        view.followButton.addTarget(self, action: #selector(handleFollowButtonToggle), for: .touchUpInside)
        view.actionsButton.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        view.emailButton.addTarget(self, action: #selector(handleComposeEmail), for: .touchUpInside)
        view.messageButton.addTarget(self, action: #selector(handleDM), for: .touchUpInside)
        view.usernameLabel.text = "@hprieto"
        view.bioLabel.text = "Kanye Omari West is an American rapper, record producer, and fashion designer. He has been influential in the 21st-century development of mainstream hip hop and popular music in general."
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
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
    
    @objc private func handleComposeEmail() {
        present(emailComposeViewController, animated: true, completion: nil)
    }
    
    @objc private func handleDM() {
        navigationController?.pushViewController(directMessageViewController, animated: true)
    }
    
    @objc private func handleCloseComposeEmail() {
        emailComposeViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Initialize Subviews
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(profileImageView)
        view.addSubview(profileNameLabel)
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        profileImageViewHeightLayoutConstraint = profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewMinHeight)
        profileImageViewHeightLayoutConstraint?.isActive = true
        
        stackView.addArrangedSubview(actionView)
        stackView.addArrangedSubview(tableView)
        
        profileNameLabel.bottomAnchor.constraint(equalTo: actionView.topAnchor).isActive = true
        profileNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftMarginConstant).isActive = true
        profileNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightMarginConstant).isActive = true
        
        tableViewHeightLayoutConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightLayoutConstraint?.isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = ._black
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: - Observers
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize",
           object is UITableView,
           let newSize: CGSize = change?[.newKey] as? CGSize {
            tableViewHeightLayoutConstraint?.constant = newSize.height
        }
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
        cell.eventImageView.setTestEventImage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventViewController._state = .resume
        let navController: UINavigationController = UINavigationController(rootViewController: eventViewController)
        present(navController, animated: true, completion: nil)
    }
    
}

// MARK: - UIScrollViewDelegate

extension ArtistViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let yAbs: CGFloat = abs(y)
        if y > 0 { return }
        profileImageViewHeightLayoutConstraint?.constant = max(profileImageViewMinHeight, yAbs)
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension ArtistViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
