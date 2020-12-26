//
//  ChatRoom.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

struct ChatRoom: Codable, Identifiable {
    
    public var id: String = UUID().uuidString
    public var userId: String?
    public var name: String?
    public var createTime: Date?
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "userId"
        case name = "name"
        case createTime = "createTime"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        userId = try values.decode(String.self, forKey: .userId)
        name = try values.decode(String.self, forKey: .name)
        createTime = try values.decode(String.self, forKey: .createTime).toJsonDate()
    }
}
