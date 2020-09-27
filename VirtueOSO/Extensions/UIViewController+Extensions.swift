//
//  UIViewController+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: Constants
    enum Margins: CGFloat {
        case formTop = 50
        case top = 100
        case left = 20
        case right = -20
        case bottom = 0
        case width = -40
    }

    // MARK: - Public Properties
    public var _darkModeEnabled: Bool {
        return UITraitCollection().userInterfaceStyle == .dark
    }

    // MARK: - Utils
    public func setTabBarItem(withIcon sfSymbol: UIImage.SFSymbol, selectedIcon: UIImage.SFSymbol, title: String? = nil, weight: UIImage.SymbolWeight = .regular, selectedWeight: UIImage.SymbolWeight = .regular, tag: Int = 0) {
        guard let image: UIImage = UIImage(sfSymbol: sfSymbol, withWeight: weight),
              let selectedImage: UIImage = UIImage(sfSymbol: selectedIcon, withWeight: selectedWeight) else { return }
        let tabBarItem: UITabBarItem = UITabBarItem(
            title: title,
            image: image,
            tag: tag)
        tabBarItem.selectedImage = selectedImage
        self.tabBarItem = tabBarItem
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Ok",
            style: .cancel,
            handler: nil)
        alertController.addAction(okAction)
        present(
            alertController,
            animated: true,
            completion: nil)
    }
}
