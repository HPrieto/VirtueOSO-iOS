//
//  SelectProfilesViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/24/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SelectProfilesViewModel {
    
    var models: [Profile]
    var states: [Bool]
    
    init() {
        models = [Profile]()
        states = [Bool]()
    }
    
    init(_ models: [Profile]) {
        self.models = models
        self.states = [Bool](repeating: false, count: self.models.count)
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
        self.states = [Bool](repeating: false, count: n)
    }
}
