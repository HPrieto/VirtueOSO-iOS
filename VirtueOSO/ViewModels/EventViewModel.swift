//
//  EventViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

class EventViewModel {
    
    var models: [Event] = [Event]()
    
    init() {
        
    }
    
    init(_ models: [Event]) {
        self.models = models
    }
}
