//
//  BasicTableViewHeader.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TitleTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
