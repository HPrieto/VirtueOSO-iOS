//
//  CheckboxTextView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/16/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class CheckboxView: ComponentView {
    
    var _checked: Bool = false {
        didSet {
            switch _checked {
            case true:
                checkboxButton.backgroundColor = _checkboxColor
            case false:
                checkboxButton.backgroundColor = .clear
            }
        }
    }
    
    var _checkboxColor: UIColor = ._black {
        didSet {
            
        }
    }
    
    var _text: String {
        set {
            textView.text = newValue
        }
        get {
            return textView.text
        }
    }
    
    lazy var textView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .regular, size: .small)
        view.textColor = ._darkGray
        return view
    }()
    
    lazy var checkboxButton: UIButton = {
        let view = UIButton()
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor._gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(
            self,
            action: #selector(handleCheckboxTapped),
            for: .touchUpInside
        )
        return view
    }()
    
    @objc private func handleCheckboxTapped() {
        _checked = !_checked
    }
    
    override func initializeSubviews() {
        addSubview(textView)
        addSubview(checkboxButton)
        
        checkboxButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        checkboxButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkboxButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        checkboxButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        textView.leftAnchor.constraint(equalTo: checkboxButton.rightAnchor, constant: 16).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}