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
    
    init(withNTestModels n: Int) {
        var testModels: [Profile] = [Profile]()
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
        self.models = testModels
    }
}
