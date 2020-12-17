//
//  HomeViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel: HomeViewModel
    
    private var collectionViewCellSize: CGSize {
        let width: CGFloat = view.frame.width * 0.8
        let height: CGFloat = width * 1.05
        return CGSize(width: Int(width), height: Int(height))
    }
    
    private var tableViewRowHeight: CGFloat {
        return collectionViewCellSize.height
    }
    
    // MARK: - Subviews
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        view.register(TitleTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier)
        view.register(EventListTableViewCell.self, forCellReuseIdentifier: EventListTableViewCell.reuseIdentifier)
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    // MARK: - Init
    
    init() {
        self.viewModel = HomeViewModel(nTestEventGroups: 10)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.eventGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header: TitleTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier) as? TitleTableViewHeaderFooterView {
            header.titleLabel.font = UIFont(type: .demiBold, size: 21)
            header.titleLabel.text = viewModel.eventGroups[section].title
            return header
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return collectionViewCellSize.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventListTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: EventListTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! EventListTableViewCell
        cell.collectionView.reloadData()
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.eventGroups[section].events?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EventCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! EventCollectionViewCell
        if let model: Event = viewModel.eventGroups[indexPath.section].events?[indexPath.row] {
            cell.descriptionLabel.text = model.description
            cell.eventNameLabel.text = "\(model.name)-\(indexPath.row)"
        }
        cell.eventImageView.setTestEventImage()
        cell.set(amount: "$2", uom: "person")
        if cell.tag % 2 == 0 {
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewCellSize
    }
}
