//
//  UIStackView+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addVerticalEmptySpace(_ height: CGFloat = 50) {
        addArrangedSubview(
            EmptySpaceView(height)
        )
    }
    
    func addToStack(
        _ message: String,
        topPadding: CGFloat = TextView()._padding.top,
        rightPadding: CGFloat = TextView()._padding.right,
        bottomPadding: CGFloat = TextView()._padding.bottom,
        leftPadding: CGFloat = TextView()._padding.left
    ) {
        let textView: TextView = TextView(
            text: message,
            textColor: ._gray,
            font: UIFont(type: .regular, size: .small)
        )
        textView._padding = UIEdgeInsets(
            top: topPadding,
            left: leftPadding,
            bottom: bottomPadding,
            right: rightPadding
        )
        addArrangedSubview(
            textView
        )
    }
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { [weak self] (arrangedSubview) in
            guard let `self` = self else { return }
            self.addArrangedSubview(arrangedSubview)
        }
    }
    
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach { [weak self] (subview) in
            guard let `self` = self else { return }
            self.removeArrangedSubview(subview)
        }
    }
    
}
