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
    
    //MARK:- Life Cycle
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
    
    //MARK:- Initialize Subviews
    private func initializeSubviews() {
        view.backgroundColor = ._primary
    }
}
