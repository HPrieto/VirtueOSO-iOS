//
//  UIViewController+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIViewController {
    
    enum Margins: CGFloat {
        case formTop = 50
        case top = 100
        case left = 20
        case right = -20
        case bottom = 0
        case width = -40
    }

    public var _darkModeEnabled: Bool {
        return UITraitCollection().userInterfaceStyle == .dark
    }

    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Ok",
            style: .cancel,
            handler: nil
        )
        alertController.addAction(okAction)
        present(
            alertController,
            animated: true,
            completion: nil
        )
    }
}
