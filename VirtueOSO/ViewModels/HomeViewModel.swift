//
//  HomeViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class HomeViewModel {
    
    var eventGroups: [EventGroup]
    
    init(groups: [EventGroup]) {
        self.eventGroups = groups
    }
    
    init(nTestEventGroups n: Int, nTestEvents x: Int = 10, testTitle: String = "Test Event Title") {
        var testGroups: [EventGroup] = [EventGroup]()
        var testEvents: [Event] = [Event]()
        
        for i in 0 ..< x {
            testEvents.append(
                Event(
                    id: UUID(),
                    title: "Yeezus Tour 202\(i)",
                    name: "Kanye West",
                    description: "The Yeezus Tour was a concert tour by American rapper Kanye West in support of West's sixth solo studio album.",
                    imageUrl: "",
                    timestamp: Date()
                )
            )
        }
        
        for i in 0 ..< n {
            testGroups.append(
                EventGroup(events: testEvents, title: "\(testTitle)-\(i)")
            )
        }
        self.eventGroups = testGroups
    }
}
