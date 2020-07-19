//
//  TextField.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TextField: UITextField {

    enum TextFieldState {
        case normal
        case edit
        case error
    }

    var _state: TextFieldState = .normal {
        didSet {
            switch _state {
            case .normal:
                layer.borderColor = _borderColor.cgColor
                backgroundColor = .clear
            case .edit:
                layer.borderColor = _editBorderColor.cgColor
                backgroundColor = .clear
            case .error:
                layer.borderColor = UIColor._redError.cgColor
                backgroundColor = ._redErrorBackground
            }
        }
    }

    var _borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
    }

    var _editBorderColor: UIColor = UIColor._secondary {
        didSet {

        }
    }

    var _placeholder: String = "" {
        didSet {
            attributedPlaceholder = NSAttributedString(
                string: _placeholder,
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor._gray
            ])
        }
    }

    var _padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {

        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    private func initialize() {
        font = UIFont(type: .regular, size: .regular)
        textColor = self._darkModeEnabled ? .white : ._black
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = ._black
        _state = .normal
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
