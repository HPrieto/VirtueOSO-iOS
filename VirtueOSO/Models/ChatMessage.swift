//
//  ChatMessage.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

struct ChatMessage: Codable, Identifiable {
    
    public var id: String = UUID().uuidString
    public var roomId: String?
    public var senderId: String?
    public var body: String?
    public var parentId: String?
    public var sendTime: Date?
    public var updateTime: Date?
    public var timeZone: String?
    public var regionCode: String?
    public var languageCode: String?
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id = "id"
        case roomId = "roomId"
        case senderId = "senderId"
        case body = "body"
        case parentId = "parentId"
        case sendTime = "sendTime"
        case updateTime = "updateTime"
        case timeZone = "timeZone"
        case regionCode = "regionCode"
        case languageCode = "languageCode"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        roomId = try values.decode(String.self, forKey: .roomId)
        senderId = try values.decode(String.self, forKey: .senderId)
        body = try values.decode(String.self, forKey: .body)
        parentId = try values.decode(String.self, forKey: .parentId)
        sendTime = try values.decode(String.self, forKey: .sendTime).toJsonDate()
        updateTime = try values.decode(String.self, forKey: .updateTime).toJsonDate()
        timeZone = try values.decode(String.self, forKey: .timeZone)
        regionCode = try values.decode(String.self, forKey: .regionCode)
        languageCode = try values.decode(String.self, forKey: .languageCode)
    }
}
