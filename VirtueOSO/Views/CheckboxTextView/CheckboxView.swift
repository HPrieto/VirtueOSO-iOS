//
//  CheckboxTextView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/16/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - CheckboxDelegate

protocol CheckboxDelegate {
    func checkboxView(_ view: CheckboxView, isChecked: Bool)
}

// MARK: - CheckboxView

class CheckboxView: ComponentView {
    
    // MARK: - Public Properties
    
    var checkboxDelegate: CheckboxDelegate?
    
    var _checked: Bool = false {
        didSet {
            switch _checked {
            case true:
                checkboxButton.backgroundColor = _checkboxColor
                if let checkmarkImage: UIImage = UIImage(sfSymbol: .checkmark, withWeight: .medium) {
                    checkboxButton.setImage(checkmarkImage, for: .normal)
                }
            case false:
                checkboxButton.backgroundColor = .clear
                checkboxButton.setImage(UIImage(), for: .normal)
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
    
    // MARK: - Subviews
    
    private(set) lazy var textView: TextView = {
        let view = TextView()
        view.textColor = ._darkGray
        return view
    }()
    
    private(set) lazy var checkboxButton: UIButton = {
        let view = UIButton()
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor._gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.backgroundColor = .clear
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(
            self,
            action: #selector(handleCheckboxTapped),
            for: .touchUpInside
        )
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleCheckboxTapped() {
        _checked = !_checked
        checkboxDelegate?.checkboxView(self, isChecked: _checked)
    }
    
    // MARK: - Initialize Subviews
    
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
