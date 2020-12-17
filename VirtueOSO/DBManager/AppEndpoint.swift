//
//  AppEndpoint.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

/// Defines a unique path associated to the app api
public enum AppEndpoint: Endpoint {
    /// User Authentication
    /// /api/login
    case login(credentials: Credentials)
    /// OAuthToken Refresh
    /// /tokens
    case token(refreshToken: String)
    /// User Logout
    /// /api/logout
    case logout
    
    public var method: String {
        switch self {
        case .login, .token:
            return "POST"
        default:
            return "GET"
        }
    }
    
    public var path: String {
        switch self {
        case .login:
            return "api/user/login"
        case .token:
            return "api/tokens"
        case .logout:
            return "api/user/logout"
        }
    }
    
    public var queryItems: [String: Any]? {
        var data: [String: Any] = [:]
        
        switch self {
        default:
            return nil
        }
        
        return data
    }
    
    public var body: [String: Any]? {
        var data: [String: Any] = [:]
        
        switch self {
        case .login(let credentials):
            data["username"] = credentials.username
            data["password"] = credentials.password
        default:
            return nil
        }
        
        return data
    }
}
