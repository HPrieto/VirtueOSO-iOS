//
//  APIError.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/29/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public struct APIError: Decodable {
    public var statusCode: Int?
    public var message: String?
    public var status: String?
    
    private enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case message = "message"
        case status = "status"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
        message = try container.decode(String.self, forKey: .message)
        status = try container.decode(String.self, forKey: .status)
    }
    
    public func toError() -> Error {
        return NSError(
            domain: "",
            code: statusCode ?? 500,
            userInfo: [
                NSLocalizedDescriptionKey: message ?? "",
                NSDebugDescriptionErrorKey: status ?? ""
            ]
        )
    }
}
