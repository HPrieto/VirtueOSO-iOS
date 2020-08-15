//
//  ChatInputBarView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/2/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - ChatInputBarView
class ChatInputBarView: ComponentView {
    
    // MARK: - ChatInputBarViewState
    enum ChatInputBarViewState {
        case normal
        case focused
        case ready
    }
    
    // MARK: - Private Properties
    
    // MARK: - Public Properties
    var _state: ChatInputBarViewState = .normal {
        didSet {
            switch _state {
            case .normal:
                textView.layer.borderColor = UIColor._gray.cgColor
                sendButton.alpha = 0
            case .focused:
                textView.layer.borderColor = UIColor._black.cgColor
                sendButton.alpha = 1
                sendButton.backgroundColor = ._gray
                sendButton.isUserInteractionEnabled = false
            case .ready:
                textView.layer.borderColor = UIColor._black.cgColor
                sendButton.alpha = 1
                sendButton.backgroundColor = ._black
                sendButton.isUserInteractionEnabled = true
            }
        }
    }
    
    var _text: String? {
        get {
            return textView.text
        }
        set {
            textView.text = newValue
        }
    }
    
    // MARK: - Subviews
    private lazy var textView: TextView = {
        let view = TextView()
        let pad: CGFloat = 5
        view._padding = UIEdgeInsets(top: pad, left: pad, bottom: pad, right: pad)
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor._gray.cgColor
        view.layer.cornerRadius = 15
        view.delegate = self
        return view
    }()
    
    private(set) lazy var sendButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = ._gray
        view.tintColor = .white
        view.setImage(._upArrow25, for: .normal)
        let pad: CGFloat = 6
        view.contentEdgeInsets = UIEdgeInsets(top: pad, left: pad, bottom: pad, right: pad)
        view.layer.cornerRadius = 12
        view.isUserInteractionEnabled = false
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    override func initializeSubviews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        addSubview(sendButton)
        
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        sendButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -5).isActive = true
        sendButton.rightAnchor.constraint(equalTo: textView.rightAnchor, constant: -5).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
}

// MARK: - UITextViewDelegate
extension ChatInputBarView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.text.count > 0 else {
            _state = .focused
            return
        }
        _state = .ready
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard textView.text.count > 0 else {
            _state = .focused
            return
        }
        _state = .ready
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        _state = .normal
    }
}
