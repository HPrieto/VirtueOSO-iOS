//
//  Follower.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

struct Follower: Codable, Identifiable {
    
    public var id: String = UUID().uuidString
    public var userId: String?
    public var followerId: String?
    public var createTime: Date?
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "userId"
        case followerId = "followerId"
        case createTime = "createTime"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        userId = try values.decode(String.self, forKey: .userId)
        followerId = try values.decode(String.self, forKey: .followerId)
        createTime = try values.decode(String.self, forKey: .createTime).toJsonDate()
    }
}
