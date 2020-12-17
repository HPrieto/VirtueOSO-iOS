//
//  EventModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

struct Event: Identifiable, Codable {
    var id: UUID
    var title: String
    var name: String
    var description: String
    var imageUrl: String
    var timestamp: Date
}
