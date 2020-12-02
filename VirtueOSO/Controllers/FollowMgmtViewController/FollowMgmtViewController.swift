//
//  FollowMgmtViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/1/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class FollowMgmtViewController: UIViewController {
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        let view = UIBarButtonItem(sfSymbol: .chevronLeft, style: .plain, target: self, action: #selector(handleBack))
        return view
    }()
    
    private(set) lazy var collectionSectionTitleHeaderView: CollectionSectionHeaderView = {
        let view = CollectionSectionHeaderView(sections: [
            "Followers",
            "Following"
        ])
        return view
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        view.addSubview(collectionSectionTitleHeaderView)
        
        collectionSectionTitleHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionSectionTitleHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionSectionTitleHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    // MARK: - Init
}

// MARK: - UICollectionViewDelegate

extension FollowMgmtViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
