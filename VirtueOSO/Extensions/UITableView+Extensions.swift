//
//  UITableView+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/22/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UITableView {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public func scrollToBottom(animated: Bool = true) {
        let numberOfSections: Int = self.numberOfSections
        let lastSection: Int = numberOfSections - 1
        let numberOfRowsInLastSection: Int = self.numberOfRows(inSection: lastSection)
        let lastRowInLastSection: Int = numberOfRowsInLastSection - 1
        let lastIndexPath: IndexPath = IndexPath(row: lastRowInLastSection, section: lastSection)
        DispatchQueue.main.async {
            self.scrollToRow(at: lastIndexPath, at: .bottom, animated: animated)
        }
    }
}
