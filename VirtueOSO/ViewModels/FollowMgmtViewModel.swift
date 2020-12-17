//
//  FollowMgmtViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/2/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class FollowMgmtViewModel {
    
    let sections: [String] = [
        "Followers",
        "Following"
    ]
    var followers: [Profile]
    var following: [Profile]
    
    init() {
        followers = [Profile]()
        following = [Profile]()
    }
    
    init(_ models: [Profile]) {
        self.followers = models
        self.following = [Profile]()
    }
    
    init(withNFollowers n: Int, nFollowing x: Int = 4) {
        var testModels: [Profile] = [Profile]()
        var testRecent: [Profile] = [Profile]()
        for i in 0 ..< n {
            testModels.append(
                Profile(
                    id: UUID(),
                    username: "HPrieto\(i)",
                    firstname: "Heriberto",
                    lastname: "Prieto",
                    imageUrl: "",
                    createdDate: Date(),
                    updatedDate: Date()
                )
            )
        }
        for i in 0 ..< x {
            testRecent.append(
                Profile(
                    id: UUID(),
                    username: "Yeezy\(i)",
                    firstname: "Kanye",
                    lastname: "West",
                    imageUrl: "",
                    createdDate: Date(),
                    updatedDate: Date()
                )
            )
        }
        self.followers = testModels
        self.following = testRecent
    }
}
