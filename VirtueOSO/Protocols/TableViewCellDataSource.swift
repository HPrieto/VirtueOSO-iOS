//
//  TableViewCellDataSource.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol TableViewCellDataSource {
    static var reuseIdentifier: String { get }
    static var cellHeight: CGFloat { get }
    func initializeSubviews()
}
