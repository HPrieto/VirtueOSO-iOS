//
//  AttributedLabel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class AttributedLabel: UILabel {
    
    // MARK: Public Properties
    var attributedStrings: [NSAttributedString]
    
    // MARK: Utils
    
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
                fontSize: fontSize)
        )
    }
    
    public func append(image: UIImage) {
        guard let attrImageString: NSAttributedString = NSAttributedString(image: image) else {
            return
        }
        self.attributedStrings.append(attrImageString)
    }
    
    public func append(attributes: [NSAttributedString]) {
        attributes.forEach { [weak self] (attrString) in
            guard let `self` = self else { return }
            self.attributedStrings.append(attrString)
        }
    }
    
    public func reloadAttributedStrings() {
        self.attributedText = NSMutableAttributedString(attributedStrings: self.attributedStrings)
    }
    
    // MARK: Initialize
    fileprivate func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(type: .regular, size: .small)
    }
    
    // MARK: Initializer
    init(attributes: [NSAttributedString]) {
        self.attributedStrings = attributes
        super.init(frame: .zero)
        initialize()
        reloadAttributedStrings()
    }
    
    override init(frame: CGRect) {
        self.attributedStrings = [NSAttributedString]()
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
