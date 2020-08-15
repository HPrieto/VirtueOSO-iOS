//
//  SettingsCellToggleView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK:- SettingsCellToggleViewDelegate
protocol SettingsCellToggleViewDelegate {
    func settingsCellToggleView(_ settingsCellToggleView: SettingsCellToggleView, didToggle isOn: Bool, tag: Int)
}

//MARK:- SettingsCellToggleView
class SettingsCellToggleView: UIView {
    
    //MARK:- Private Properties
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    //MARK:- Public Properties
    var delegate: SettingsCellToggleViewDelegate?
    
    var _height: CGFloat = 60 {
        didSet {
            heightLayoutConstraint?.constant = _height
        }
    }
    
    var _isOn: Bool {
        set {
            switchView.isOn = newValue
        }
        get {
            return switchView.isOn
        }
    }
    
    //MARK:- Views
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
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
    
    private lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.onTintColor = ._tertiary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(
            self,
            action: #selector(handleSwitchToggled(switch:)),
            for: .valueChanged
        )
        return view
    }()
    
    // MARK: - Utils
    
    private func setImage(_ image: UIImage?) {
        self.imageView.image = image
    }
    
    // MARK:- InitializeSubviews
    private func initializeSubviews(title: String, image: UIImage? = nil, detail: String? = nil, detailTextColor: UIColor = .black) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        
        addSubview(titleLabel)
        addSubview(switchView)
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: switchView.leftAnchor, constant: -10).isActive = true
        
        switchView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        switchView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40).isActive = true
        
        /// If view should display an image, align titleLabel to the right of `imageView`
        /// If view should NOT display an image, anchor `titleLabel` to left of `SettingsCellToggleView`
        if let _ = image {
            addSubview(imageView)
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
            imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -30).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
            self.setImage(image)
        } else {
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        }
    }
    
    //MARK:- Handlers
    @objc private func handleSwitchToggled(switch: UISwitch) {
        delegate?.settingsCellToggleView(self, didToggle: true, tag: tag)
    }
    
    //MARK:- Init
    init(
        title: String,
        systemImageName: String,
        isOn: Bool = false,
        tag: Int = 0,
        delegate: SettingsCellToggleViewDelegate? = nil
    ) {
        let systemImage: UIImage? = UIImage(systemName: systemImageName)
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.tag = tag
        self.switchView.isOn = isOn
        self.delegate = delegate
        
        initializeSubviews(title: title, image: systemImage)
    }
    
    init(
        title: String,
        isOn: Bool = false,
        image: UIImage? = nil,
        tag: Int = 0,
        delegate: SettingsCellToggleViewDelegate? = nil
    ) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.tag = tag
        self.switchView.isOn = isOn
        self.delegate = delegate
        
        initializeSubviews(title: title, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
