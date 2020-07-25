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
    
    func addTextToStack(_ message: String) {
        addArrangedSubview(
            TextView(
                text: message,
                textColor: ._gray,
                font: UIFont(type: .regular, size: .small)
            )
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
