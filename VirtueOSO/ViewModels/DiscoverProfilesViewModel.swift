//
//  DiscoverProfilesViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/24/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DiscoverProfilesViewModel {
    
    var models: [Profile]
    var recentModels: [Profile]
    
    init() {
        models = [Profile]()
        recentModels = [Profile]()
    }
    
    init(_ models: [Profile]) {
        self.models = models
        self.recentModels = [Profile]()
    }
    
    init(withNTestModels n: Int, xRecent x: Int = 4) {
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
        self.models = testModels
        self.recentModels = testRecent
    }
}
