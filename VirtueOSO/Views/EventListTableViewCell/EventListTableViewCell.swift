//
//  EventListTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class EventListTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var collectionViewHeightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    
    public static var reuseIdentifier: String = "event-list-table-view-cell"
    
    // MARK: - Subviews
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.isPagingEnabled = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize
    
    private func initialize() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is UICollectionView, keyPath == "contentSize", let contentSize: CGSize = change?[.newKey] as? CGSize {
            print("ObservedSize: ", contentSize)
            //collectionViewHeightLayoutConstraint?.constant = contentSize.height
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }
}
