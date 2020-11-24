//
//  DirectMessage.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/21/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

struct DirectMessage: Identifiable {
    public var id: UUID
    public var userId: Int?
    public var username: String?
    public var message: String?
}
