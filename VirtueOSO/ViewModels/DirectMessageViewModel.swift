//
//  DirectMessageViewModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/21/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

class DirectMessageViewModel {
    var models: [DirectMessage]
    
    init(models: [DirectMessage]) {
        self.models = models
    }
    
    init(withNTestModels n: Int = 10) {
        var testModels: [DirectMessage] = [DirectMessage]()
        for i in 0 ..< n {
            testModels.append(
                DirectMessage(
                    id: UUID(),
                    userId: 0,
                    username: "yeezy\(i)",
                    message: "Changing the background color of UITableViewHeaderFooterView is not supported. Use the background view configuration instead."
                )
            )
        }
        self.models = testModels
    }
    
}
