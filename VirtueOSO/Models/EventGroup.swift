//
//  EventGroup.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/6/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

struct EventGroup: Codable {
    
    var events: [Event]?
    var title: String?
    
    init(events: [Event], title: String?) {
        self.events = events
        self.title = title
    }
    
    init(from decoder: Decoder) throws {
        
    }
}
