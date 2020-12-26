//
//  ChatModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

struct ChatModel: Codable {
    
    public var chatRoom: ChatRoom?
    public var messages: [ChatMessage]?
    public var members: [ChatRoomMember]?
    
}
