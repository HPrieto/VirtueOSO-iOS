//
//  CollectionSectionHeaderView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/1/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class CollectionSectionHeaderView: UIView {
    
    // MARK: - Private Properties
    
    private var selectedItem: Int = 0 {
        didSet {
            let section: Int = 0
            for i in 0 ..< collectionView.numberOfItems(inSection: section) {
                let cellIndexPath: IndexPath = IndexPath(item: i, section: section)
                if let cellLabel: UILabel = collectionView.cellForItem(at: cellIndexPath)?.contentView.subviews.first(where: { (subview: UIView) -> Bool in
                    guard let label = subview as? UILabel else { return false }
                    return label.tag == 1
                }) as? UILabel {
                    cellLabel.textColor = i == selectedItem ? .black : .lightGray
                }
            }
        }
    }
    
    private let cellId: String = "collection-section-header-view-cell"
    
    private var bottomBarViewLeftLayoutConstraint: NSLayoutConstraint?
    
    private var bottomBarViewWidthMultiplier: CGFloat {
        1.0 / CGFloat(sections.count)
    }
    
    private var cellSize: CGSize {
        CGSize(
            width: bounds.width / CGFloat(sections.count),
            height: heightAnchorConstant
        )
    }
    
    private let heightAnchorConstant: CGFloat = 40
    
    // MARK: - Public Properties
    
    private(set) var sections: [String]
    
    // MARK: - Subviews
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.scrollIndicatorInsets = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return view
    }()
    
    private(set) lazy var bottomBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ._lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize
    
    private func initialize() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        addSubview(bottomBarBackgroundView)
        
        bottomBarBackgroundView.addSubview(bottomBarView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heightAnchorConstant).isActive = true
        
        bottomBarBackgroundView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomBarBackgroundView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomBarBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomBarBackgroundView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        
        bottomBarView.heightAnchor.constraint(equalTo: bottomBarBackgroundView.heightAnchor).isActive = true
        bottomBarView.bottomAnchor.constraint(equalTo: bottomBarBackgroundView.bottomAnchor).isActive = true
        bottomBarView.widthAnchor.constraint(equalTo: bottomBarBackgroundView.widthAnchor, multiplier: bottomBarViewWidthMultiplier).isActive = true
        bottomBarViewLeftLayoutConstraint = bottomBarView.leftAnchor.constraint(equalTo: leftAnchor)
        bottomBarViewLeftLayoutConstraint?.isActive = true
        
        bottomAnchor.constraint(equalTo: bottomBarBackgroundView.bottomAnchor).isActive = true
    }
    
    // MARK: - Init
    
    init(sections: [String]) {
        self.sections = sections
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionSectionHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let label: UILabel = UILabel()
        label.tag = 1
        label.text = sections[indexPath.row]
        label.numberOfLines = 1
        label.font = UIFont(type: .demiBold, size: 15)
        label.textColor = selectedItem == indexPath.row ? .black : .lightGray
        label.backgroundColor = .clear
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        
        label.frame = cell.contentView.frame
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bottomBarViewLeftLayoutConstraint?.constant = CGFloat(indexPath.row) * cellSize.width
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.selectedItem = indexPath.row
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}
