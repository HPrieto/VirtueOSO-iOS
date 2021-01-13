//
//  BorderedDatePicker.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 1/5/21.
//  Copyright © 2021 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK:- Init
class BorderedDatePicker: ComponentView {
    
    //MARK:- Enums
    enum State {
        case normal
        case edit
        case error
    }
    
    enum DefaultStyle: CGFloat {
        case cornerRadius = 8
        case paddingLeftRight = 23
        case paddingTopBottom = 13
    }
    
    //MARK:- Public Properties
    
    var _state: State = .normal {
        didSet {
            switch _state {
            case .normal:
                layer.borderColor = _borderColor.cgColor
                layer.borderWidth = _borderWidth
                layer.maskedCorners = _roundCorners
            case .edit:
                layer.borderColor = UIColor._black.cgColor
                layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
                ]
            case .error:
                layer.borderColor = UIColor._redError.cgColor
            }
        }
    }
    
    var _title: String = "" {
        didSet {
            titleTextView.text = _title
        }
    }
    
    var _date: Date {
        get {
            datePicker.date
        }
        set {
            datePicker.date = newValue
        }
    }
    
    var _cornerRadius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = _cornerRadius
        }
    }
    
    /// Sets the corner radius of individual corners
    /// .layerMinXMinYCorner = Top left corner
    /// .layerMaxXMinYCorner = Top right corner
    /// .layerMinXMaxYCorner = Bottom left corner
    /// .layerMaxXMaxYCorder = Bottom right corner
    var _roundCorners: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner
        ] {
        didSet {
            layer.maskedCorners = _roundCorners
        }
    }
    
    var _borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = _borderWidth
        }
    }
    
    var _textColor: UIColor = ._black {
        didSet {
            
        }
    }
    
    var _font: UIFont? = UIFont(type: .regular, size: .small) {
        didSet {
            titleTextView.font = _font
        }
    }
    
    var _borderColor: UIColor = ._gray {
        didSet {
            layer.borderColor = _borderColor.cgColor
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var titleTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .regular, size: 11)
        view.textColor = ._gray
        return view
    }()
    
    private(set) lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.tintColor = ._black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    override func initializeSubviews() {
        
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        layer.borderWidth = _borderWidth
        layer.borderColor = _borderColor.cgColor
        
        addSubview(titleTextView)
        addSubview(datePicker)
        
        titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 23).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -23).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 2).isActive = true
        datePicker.leftAnchor.constraint(equalTo: titleTextView.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: titleTextView.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13).isActive = true
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Handlers
    
    @objc private func handleViewTapped() {
        datePicker.becomeFirstResponder()
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    init(title: String, date: Date = Date()) {
        super.init(frame: .zero)
        initializeSubviews()
        self._date = date
        self._title = title
        self.titleTextView.text = title
        self.datePicker.date = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
