//
//  TextFieldView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TextFieldView: ComponentView {
    
    var _label: String = "" {
        didSet {
            textView.text = _label
        }
    }
    
    var _placeholder: String = "" {
        didSet {
            textField.placeholder = _placeholder
        }
    }
    
    var _color: UIColor = .black {
        didSet {
            border.backgroundColor = _color
            textField.textColor = _color
            textView.textColor = _color
            textView.tintColor = _color
        }
    }
    
    var _tintColor: UIColor = ._lightGray {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(
                string: _placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: _tintColor]
            )
        }
    }
    
    lazy var textView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .demiBold, size: .small)
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .clear
        view.font = UIFont(type: .regular, size: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var border: Border = {
        return Border()
    }()
    
    init(label: String, placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self._label = label
        self._placeholder = placeholder
        textView.text = _label
        textField.placeholder = placeholder
    }
    
    override func initializeSubviews() {
        addSubview(textView)
        addSubview(textField)
        addSubview(border)
        
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        textField.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 5).isActive = true
        textField.leftAnchor.constraint(equalTo: textView.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        border.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        border.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    override func updateSubviews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
