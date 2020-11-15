//
//  LiveStreamViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/18/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit
import AVKit

class LiveStreamViewController: UIViewController {
    
    // MARK: - Subviews
    
    private(set) lazy var heartButton: UIButton = {
        let button = UIButton(sfSymbol: .heartFill)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var commentButton: UIButton = {
        let button = UIButton(sfSymbol: .ellipsesBubbleFill)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var shareButton: UIButton = {
        let button = UIButton(sfSymbol: .arrowClockwise)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .black
        
        view.addSubview(commentButton)
        view.addSubview(heartButton)
        view.addSubview(shareButton)
        
        
    }
    
    // MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
