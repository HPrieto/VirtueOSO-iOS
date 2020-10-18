//
//  ImageCollectionView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    // MARK: - Private Properties
    public var views: [UIView] = [UIView]() {
        didSet {
            
        }
    }
    
    var stepViews: [UIImageView] = [UIImageView]() {
        didSet {
            
        }
    }
    
    // MARK: - Public Properties
    var currentStep: Int = 0 {
        didSet {
            
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var stepStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        addSubview(stepStackView)
        
        stepStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stepStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stepStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        stepStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    // MARK: - Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate
extension CollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .blue : .orange
        return cell
    }
}
