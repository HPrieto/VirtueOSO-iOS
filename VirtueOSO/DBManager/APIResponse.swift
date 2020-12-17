//
//  APIResponse.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public protocol SuccessErrorResponse {
    var success: Bool { get }
    var errors: [String] { get }
}

public struct APIResponse<T: Decodable>: SuccessErrorResponse, Decodable {
    public let success: Bool
    public let errors: [String]
    public let results: T?
    public let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case success
        case errors
        case data
        case results
        case totalResults
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        errors = try container.decode([String].self, forKey: .errors)
        
        var decodingError: Error?
        
        do {
            results = try container.decode(T.self, forKey: .data)
            totalResults = 0
            return
        } catch {
            decodingError = error
        }
        
        do {
            let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
            results = try dataContainer.decode(T.self, forKey: .results)
            totalResults = try dataContainer.decode(Int.self, forKey: .totalResults)
            return
        } catch {
            decodingError = nil
        }
        
        let context = DecodingError.Context(codingPath: [CodingKeys.data], debugDescription: "", underlyingError: decodingError)
        throw DecodingError.dataCorrupted(context)
    }
}
