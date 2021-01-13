//
//  AvailabilityModel.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 1/2/21.
//  Copyright © 2021 Heriberto Prieto. All rights reserved.
//

import Foundation

public typealias AvailabilityCompletion = (Result<AvailabilityModel, Swift.Error>) -> Void

public struct AvailabilityModel: Decodable {
    
    public var available: Bool?
    public var message: String?
    
    fileprivate enum CodingKeys: String, CodingKey {
        case available
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        available = try container.decodeIfPresent(Bool.self, forKey: .available)
        message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}
