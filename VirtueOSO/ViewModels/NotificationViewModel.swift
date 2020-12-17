//
//  NotificationViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/2/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

class NotificationViewModel {
    
    public var numberOfRows: Int {
        return newMessages.count + newFollowers.count
    }
    
    var newMessages: [DirectMessage]
    var newFollowers: [Profile]
    
    init(newMessages: [DirectMessage], newFollowers: [Profile]) {
        self.newMessages = newMessages
        self.newFollowers = newFollowers
    }
    
    init(nTestMessages n: Int, nTestFollowers x: Int) {
        var testNewMessages: [DirectMessage] = [DirectMessage]()
        var testNewFollowers: [Profile] = [Profile]()
        
        for i in 0 ..< n {
            testNewMessages.append(
                DirectMessage(
                    id: UUID(),
                    userId: 0,
                    username: "valee",
                    message: "Test Message \(i)"
                )
            )
        }
        
        for i in 0 ..< x {
            testNewFollowers.append(
                Profile(
                    id: UUID(),
                    username: "valee\(i)",
                    firstname: "No",
                    lastname: "Idea",
                    imageUrl: "",
                    createdDate: Date(),
                    updatedDate: Date()
                )
            )
        }
        self.newMessages = testNewMessages
        self.newFollowers = testNewFollowers
    }
}
