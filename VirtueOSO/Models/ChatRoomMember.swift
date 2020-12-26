//
//  ChatRooms.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

struct ChatRoomMember: Codable, Identifiable {
    
    public var id: String = UUID().uuidString
    public var roomId: String?
    public var userId: String?
    public var isAdmin: Bool?
    public var timeZone: String?
    public var regionCode: String?
    public var languageCode: String?
    public var createTime: Date?
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id = "id"
        case roomId = "roomId"
        case userId = "userId"
        case isAdmin = "isAdmin"
        case timeZone = "timeZone"
        case regionCode = "regionCode"
        case languageCode = "languageCode"
        case createTime = "createTime"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        roomId = try values.decode(String.self, forKey: .roomId)
        userId = try values.decode(String.self, forKey: .userId)
        isAdmin = try values.decode(Int.self, forKey: .isAdmin) == 1 ? true : false
        timeZone = try values.decode(String.self, forKey: .timeZone)
        regionCode = try values.decode(String.self, forKey: .regionCode)
        languageCode = try values.decode(String.self, forKey: .languageCode)
        createTime = try values.decode(String.self, forKey: .createTime).toJsonDate()
    }
}
