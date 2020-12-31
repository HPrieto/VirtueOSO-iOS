//
//  Endpoint.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

protocol Endpoint {
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
        
        if let body = self.body,
           let jsonData = JSON.data(from: body) {
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print("HttpBody: ", String(data: jsonData, encoding: .utf8) ?? "None.")
        }
        
        return request
    }
}
