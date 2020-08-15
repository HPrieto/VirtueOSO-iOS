//
//  SettingsPickerView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SettingsPickerView: UIView {
    
    // MARK: - Private Properties
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    override var tag: Int {
        set {
            pickerView.tag = newValue
        }
        get {
            return pickerView.tag
        }
    }
    
    var delegate: UIPickerViewDelegate? {
        didSet {
            pickerView.delegate = delegate
        }
    }
    
    var dataSource: UIPickerViewDataSource? {
        didSet {
            pickerView.dataSource = dataSource
        }
    }
    
    var _height: CGFloat = 60 {
        didSet {
            heightLayoutConstraint?.constant = _height
        }
    }
    
    var _title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.font = UIFont(type: .regular, size: .small)
        view.textColor = ._gray
        view.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Handlers
    @objc private func handleTap() {
        pickerView.becomeFirstResponder()
    }
    
    // MARK: - Utils
    public override func becomeFirstResponder() -> Bool {
        pickerView.becomeFirstResponder()
        return true
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        
        addSubview(titleLabel)
        addSubview(pickerView)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
        
        pickerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pickerView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Utils
    public func setTitle(title: String) {
        _title = title
    }
    
    // MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title: title)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
