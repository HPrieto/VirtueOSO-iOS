//
//  Endpoint.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public protocol Endpoint {
    /// Request Method Type
    var method: String { get }
    /// API Endpoint Path
    var path: String { get }
    /// URL Encoded Query Parameters (i.e. ?)
    var queryItems: [String : Any]? { get }
    /// JSON Encoded Body
    var body: [String: Any]? { get }
}

extension Endpoint {
    
    /**
     Build URLRequest
     */
    func urlRequest(using baseURL: URL) throws -> URLRequest {
        let url: URL = baseURL.appendingPathComponent(path)
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
