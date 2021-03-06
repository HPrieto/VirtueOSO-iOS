//
//  BorderedTextField.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK:- Init
class BorderedTextField: ComponentView {
    
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
    var _secureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = _secureTextEntry
        }
    }
    
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
    
    var _placeholder: String? {
        didSet {
            
        }
    }
    
    var _text: String? {
        didSet {
            textField.text = _text
        }
    }
    
    var _contentType: UITextContentType = .username {
        didSet {
            textField.textContentType = _contentType
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
            textField.textColor = _textColor
        }
    }
    
    var _font: UIFont? = UIFont(type: .regular, size: .small) {
        didSet {
            titleTextView.font = _font
            textField.font = _font
        }
    }
    
    var _borderColor: UIColor = ._gray {
        didSet {
            layer.borderColor = _borderColor.cgColor
        }
    }
    
    //MARK:- Subviews
    
    private(set) lazy var titleTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .regular, size: 11)
        view.textColor = ._gray
        return view
    }()
    
    private(set) lazy var textField: UITextField = {
        let view = UITextField()
        view.font = UIFont(type: .regular, size: .small)
        view.autocorrectionType = .no
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:- Initialize Subviews
    override func initializeSubviews() {
        
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        layer.borderWidth = _borderWidth
        layer.borderColor = _borderColor.cgColor
        
        addSubview(titleTextView)
        addSubview(textField)
        
        titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 23).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -23).isActive = true
        
        textField.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 2).isActive = true
        textField.leftAnchor.constraint(equalTo: titleTextView.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: titleTextView.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13).isActive = true
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    //MARK:- Handlers
    @objc func handleViewTapped() {
        textField.becomeFirstResponder()
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
