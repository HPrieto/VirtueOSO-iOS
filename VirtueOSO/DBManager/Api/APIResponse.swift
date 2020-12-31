//
//  APIResponse.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public struct APIResponse<T: Decodable>: Decodable {
    public let error: APIError?
    public let data: T?
    
    private enum CodingKeys: String, CodingKey {
        case error = "error"
        case data = "data"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        error = try container.decodeIfPresent(APIError.self, forKey: .error)
        data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}
