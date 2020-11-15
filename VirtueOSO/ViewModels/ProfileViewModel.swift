//
//  ProfileViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    var models: [Profile]
    
    init() {
        models = [Profile]()
    }
    
    init(_ models: [Profile]) {
        self.models = models
    }
}
