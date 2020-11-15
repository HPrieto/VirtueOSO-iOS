//
//  ImageCountView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class ImageCountView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var countLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(type: .demiBold, size: 21)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize
    
    private func initialize() {
        addSubview(imageView)
        addSubview(countLabel)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        countLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
    
    // MARK: - Init
    
    init(sfSymbol: UIImage.SFSymbol, weight: UIImage.SymbolWeight = .regular) {
        super.init(frame: CGRect.zero)
        imageView.image = UIImage(sfSymbol: sfSymbol, withWeight: weight)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
