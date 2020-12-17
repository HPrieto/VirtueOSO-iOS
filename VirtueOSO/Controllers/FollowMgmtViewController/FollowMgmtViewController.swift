//
//  FollowMgmtViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/1/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class FollowMgmtViewController: UIViewController {
    
    enum State {
        case followers
        case following
    }
    
    var state: State = .followers {
        didSet {
            switch state {
            case .followers:
                collectionSectionTitleHeaderView.selectedItem = 0
                collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            case .following:
                collectionSectionTitleHeaderView.selectedItem = 1
                collectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let followingCellReuseIdentifier: String = "following-mgmt-collection-view-cell"
    private let followersCellReuseIdentifier: String = "followers-mgmt-collection-view-cell"
    
    private var cellSize: CGSize {
        return CGSize(
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
    }
    
    // MARK: - Public Properties
    
    public let viewModel: FollowMgmtViewModel
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        let view = UIBarButtonItem(sfSymbol: .chevronLeft, style: .plain, target: self, action: #selector(handleBack))
        return view
    }()
    
    private(set) lazy var collectionSectionTitleHeaderView: CollectionSectionHeaderView = {
        let view = CollectionSectionHeaderView(sections: viewModel.sections)
        view.delegate = self
        return view
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: followingCellReuseIdentifier)
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: followersCellReuseIdentifier)
        return view
    }()
    
    private(set) lazy var followersTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.tag = 1
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = true
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        view.register(SearchBarTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: SearchBarTableViewHeaderFooterView.reuseIdentifier)
        view.register(FollowProfileTableViewCell.self, forCellReuseIdentifier: FollowProfileTableViewCell.reuseIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private(set) lazy var followingTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.tag = 2
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = true
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        view.register(SearchBarTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: SearchBarTableViewHeaderFooterView.reuseIdentifier)
        view.register(FollowProfileTableViewCell.self, forCellReuseIdentifier: FollowProfileTableViewCell.reuseIdentifier)
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        view.backgroundColor = .white
        
        navigationItem.title = "hprieto"
        
        view.addSubview(collectionSectionTitleHeaderView)
        view.addSubview(collectionView)
        
        collectionSectionTitleHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionSectionTitleHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionSectionTitleHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: collectionSectionTitleHeaderView.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    init() {
        viewModel = FollowMgmtViewModel(withNFollowers: 10, nFollowing: 20)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate

extension FollowMgmtViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier: String
        switch indexPath.row {
        case 0:
            reuseIdentifier = followersCellReuseIdentifier
        default:
            reuseIdentifier = followingCellReuseIdentifier
        }
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        switch indexPath.row {
        case 0:
            cell.contentView.addSubview(followersTableView)
            followersTableView.frame = cell.contentView.frame
        default:
            cell.contentView.addSubview(followingTableView)
            followingTableView.frame = cell.contentView.frame
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let visibleIndexPath: IndexPath = collectionView.indexPathsForVisibleItems.first else {
            return
        }
        state = visibleIndexPath.row == 0 ? .followers : .following
    }
}

// MARK: - CollectionSectionHeaderViewDelegate

extension FollowMgmtViewController: CollectionSectionHeaderViewDelegate {
    
    func collectionSectionHeaderView(_ collectionSectionHeaderView: CollectionSectionHeaderView, didSelectItemAt index: Int) {
        state = index == 0 ? .followers : .following
    }
}

// MARK: - UITableViewDelegate

extension FollowMgmtViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return viewModel.followers.count
        default:
            return viewModel.following.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: SearchBarTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SearchBarTableViewHeaderFooterView.reuseIdentifier
        ) as! SearchBarTableViewHeaderFooterView
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: FollowProfileTableViewCell.reuseIdentifier, for: indexPath) as! FollowProfileTableViewCell
        let model: Profile
        switch tableView.tag {
        case 1:
            model = viewModel.followers[indexPath.row]
            cell.followButton.alpha = 0
        default:
            model = viewModel.following[indexPath.row]
            cell.followButton.alpha = 1
            cell.state = .following
        }
        cell.ellispesButton.alpha = 0
        cell.usernameLabel.text = "\(model.username)"
        cell.nameLabel.text = "\(model.firstname) \(model.lastname)"
        cell.profileImageView.setTestImage()
        return cell
    }
}
