//
//  DirectMessageTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DirectMessageTableView: UITableView {
    
    // MARK: - Initialize
    
    private func initialize() {
        separatorStyle = .none
        register(DirectMessageTableViewCell.self, forCellReuseIdentifier: DirectMessageTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
