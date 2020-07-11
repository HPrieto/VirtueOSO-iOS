//
//  ComponentView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class ComponentView: UIView {
    
    func initializeSubviews() {
        
    }
    
    func updateSubviews() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
