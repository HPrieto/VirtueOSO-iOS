//
//  DatePickerViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 1/2/21.
//  Copyright © 2021 Heriberto Prieto. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    // MARK: - Subviews
    
    private(set) lazy var label: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont(type: .bold, size: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews'
    
    private func initializeSubviews() {
        
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
