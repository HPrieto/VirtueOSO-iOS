//
//  TableUpateStatusModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/29/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public typealias TableStatusCompletion = (Result<TableUpdateStatusModel, Swift.Error>) -> Void

public struct TableUpdateStatusModel: Codable {
    
    public var fieldCount: Int?
    public var affectedRows: Int?
    public var insertId: Int?
    public var serverStatus: Int?
    public var warningCount: Int?
    public var message: String?
    public var protocol41: Bool?
    public var changedRows: Int?
    
    fileprivate enum codingKeys: String, CodingKey {
        case fieldCount
        case affectedRows
        case insertId
        case serverStatus
        case warningCount
        case message
        case protocol41
        case changedRows
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fieldCount = try container.decodeIfPresent(Int.self, forKey: .fieldCount)
        affectedRows = try container.decodeIfPresent(Int.self, forKey: .affectedRows)
        insertId = try container.decodeIfPresent(Int.self, forKey: .insertId)
        serverStatus = try container.decodeIfPresent(Int.self, forKey: .serverStatus)
        warningCount = try container.decodeIfPresent(Int.self, forKey: .warningCount)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        protocol41 = try container.decodeIfPresent(Bool.self, forKey: .protocol41)
        changedRows = try container.decodeIfPresent(Int.self, forKey: .changedRows)
    }
}
