//
//  SettingsCellView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK:- SettingsCellViewDelegate
protocol SettingsCellViewDelegate {
    func settingsCellView(_ settingsCellView: SettingsCellView, didTap tag: Int)
}

//MARK:- SettingsCellView
class SettingsCellView: UIView {
    
    //MARK:- Private Properties
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    //MARK:- Public Properties
    var delegate: SettingsCellViewDelegate?
    
    var _height: CGFloat = 60 {
        didSet {
            heightLayoutConstraint?.constant = _height
        }
    }
    
    var _detailTextColor: UIColor = ._secondary {
        didSet {
            detailLabel.textColor = _detailTextColor
        }
    }
    
    var _image: UIImage? {
        didSet {
            let padding = UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5)
            imageView.image = _image?.withAlignmentRectInsets(padding)
        }
    }
    
    //MARK:- Views
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = ._black
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .regular, size: .small)
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var detailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: .small)
        view.numberOfLines = 1
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.tintColor = ._gray
        view.contentMode = .scaleAspectFit
        let padding: CGFloat = 5
        let imageConfiguration: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(weight: .light)
        view.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfiguration)?
            .withAlignmentRectInsets(
                UIEdgeInsets(
                    top: -padding,
                    left: -padding,
                    bottom:-padding,
                    right: -padding
                )
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Utils
    private func setImage(_ image: UIImage?) {
        self._image = image
    }
    
    //MARK:- InitializeSubviews
    private func initializeSubviews(title: String, image: UIImage? = nil, detail: String? = nil, detailTextColor: UIColor = .black) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        
        addSubview(titleLabel)
        addSubview(accessoryImageView)
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        accessoryImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        accessoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        accessoryImageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40).isActive = true
        accessoryImageView.widthAnchor.constraint(equalTo: accessoryImageView.heightAnchor).isActive = true
        
        /// If view should display an image, align titleLabel to the right of `imageView`
        /// If view should NOT display an image, anchor `titleLabel` to left of `SettingsCellView`
        if let _ = image {
            addSubview(imageView)
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
            imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -30).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
        } else {
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        }
        
        /// If `SettingsCellView` should display detail text, align `detailTextLabel` to left of `accessoryImageView`
        if let detail = detail {
            detailLabel.text = detail
            detailLabel.textColor = detailTextColor
            addSubview(detailLabel)
            detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            detailLabel.rightAnchor.constraint(equalTo: accessoryImageView.leftAnchor, constant: -20).isActive = true
            detailLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        } else {
            titleLabel.rightAnchor.constraint(equalTo: accessoryImageView.leftAnchor, constant: -10).isActive = true
        }
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK:- Handlers
    @objc private func handleTap() {
        delegate?.settingsCellView(self, didTap: tag)
    }
    
    //MARK:- Init
    init(
        title: String,
        systemImageName: String,
        detail: String? = nil,
        detailTextColor: UIColor = .black,
        tag: Int = 0,
        delegate: SettingsCellViewDelegate? = nil
    ) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.tag = tag
        self.delegate = delegate
        let image: UIImage? = UIImage(systemName: systemImageName)
        self.setImage(image)
        
        initializeSubviews(title: title, image: image, detail: detail, detailTextColor: detailTextColor)
    }
    
    init(
        title: String,
        image: UIImage? = nil,
        detail: String? = nil,
        detailTextColor: UIColor = .black,
        tag: Int = 0,
        delegate: SettingsCellViewDelegate? = nil
    ) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.tag = tag
        self.delegate = delegate
        self.setImage(image)
        
        initializeSubviews(title: title, image: image, detail: detail, detailTextColor: detailTextColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
