//
//  AttributedTextView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - AttributedTextView
class AttributedTextView: UITextView {
    
    // MARK: Public Properties
    var attributedStrings: [NSAttributedString]
    
    // MARK: Utils
    
    public func removeAllAttributes() {
        self.attributedStrings = [NSAttributedString]()
        self.attributedText = NSAttributedString(string:"")
    }
    
    public func reloadAttributedStrings() {
        self.attributedText = NSMutableAttributedString(attributedStrings: self.attributedStrings)
    }
    
    public func append(_ attrString: NSAttributedString) {
        self.attributedStrings.append(attrString)
    }
    
    public func append(string: String,
                       color: UIColor = ._black,
                       fontType: UIFont.FontType = .regular,
                       fontSize: UIFont.FontSize = .regular) {
        self.attributedStrings.append(
            NSAttributedString(
                string: string,
                color: color,
                fontType: fontType,
                fontSize: fontSize
            )
        )
    }
    
    public func append(image: UIImage) {
        guard let attributedString: NSAttributedString = NSAttributedString(image: image) else {
            return
        }
        self.attributedStrings.append(attributedString)
    }
    
    // MARK: Initialize
    fileprivate func initialize() {
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(type: .regular, size: .small)
    }
    
    // MARK: Initializer
    init(attributes: [NSAttributedString]) {
        self.attributedStrings = attributes
        super.init(frame: .zero, textContainer: nil)
        self.initialize()
        self.reloadAttributedStrings()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        self.attributedStrings = [NSAttributedString]()
        super.init(frame: .zero, textContainer: textContainer)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AttributedTextView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(URL)
        return true
    }
}
