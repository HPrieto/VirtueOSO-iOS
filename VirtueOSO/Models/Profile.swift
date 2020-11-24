//
//  Profile.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

struct Profile: Identifiable {
    public var id: UUID
    public var username: String
    public var firstname: String
    public var lastname: String
    public var imageUrl: String
    public var createdDate: Date
    public var updatedDate: Date
}
