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
    
    // MARK: - Users Endpoints
    
    /// `/api/users/signup`
    case signup(user: User)
    /// `/api/login`
    case login(credentials: Credentials)
    /// OAuthToken Refresh
    /// `/tokens`
    case token(refreshToken: String)
    /// User Logout
    /// `/api/users/logout`
    case logout
    /// Fetch user with id
    /// `api/users/:id`
    case getUser(id: Int)
    /// Fetch user with username
    /// `api/users/username/:username`
    case getUserWithUsername(username: String)
    /// Check if a username is available.
    /// `api/users/username/:username/available`
    case isUsernameAvailable(username: String)
    /// Check if an email is available.
    /// `api/users/email/:email/available`
    case isEmailAvailable(email: String)
    /// Update user password
    /// `api/users/:id/update/password`
    case updatePassword(id: Int, oldPassword: String, newPassword: String)
    /// Get users following user
    /// `api/users/:userId/followers`
    case userFollowers(id: Int)
    /// Get users followed by user
    /// `api/users/:followerId/following`
    case userFollowing(id: Int)
    /// Follow user
    /// `api/users/:followerId/follow/:userId`
    case follow(followerId: Int, userId: Int)
    /// Unfollow user
    /// `api/users/:followerId/unfollow/:userId`
    case unfollow(followerId: Int, userId: Int)
    
    // MARK: - ChatRoom Endpoints
    
    /// Fetch all chatrooms that user is a part of by userId
    /// `api/chat/rooms/:userId`
    case getChatRooms(userId: Int)
    /// Fetch ChatModel by roomId
    /// `api/chat/:roomId`
    case getChatModel(roomId: Int)
    
    // MARK: - ChatRooms
    
    public var method: String {
        switch self {
        case .signup, .token:
            return "POST"
        case .login, .updatePassword:
            return "PUT"
        case .unfollow:
            return "DELETE"
        default:
            return "GET"
        }
    }
    
    public var path: String {
        switch self {
        
        // MARK: - Users paths
        case .signup(_):
            return "api/users/signup"
        case .login:
            return "api/users/login"
        case .token:
            return "api/tokens"
        case .logout:
            return "api/users/logout"
        case .getUser(let id):
            return "api/users/\(id)"
        case .getUserWithUsername(let username):
            return "api/users/username/\(username)"
        case .isUsernameAvailable(let username):
            return "api/users/username/\(username)/available"
        case .isEmailAvailable(let email):
            return "api/users/email/\(email)/available"
        case .updatePassword(let id, _, _):
            return "api/users/\(id)/update/password"
        case .userFollowers(let id):
            return "api/users/\(id)/followers"
        case .userFollowing(let id):
            return "api/users/\(id)/following"
        case .follow(let followerId, let userId):
            return "api/users/\(followerId)/follow/\(userId)"
        case .unfollow(let followerId, let userId):
            return "api/users/\(followerId)/unfollow/\(userId)"
            
        // MARK: - ChatRooms paths
        case .getChatRooms(let userId):
            return "api/chat/rooms/\(userId)"
        case .getChatModel(let roomId):
            return "api/chat/\(roomId)"
        }
    }
    
    public var queryItems: [String: Any]? {
        let data: [String: Any] = [:]
        
        return data
    }
    
    public var body: [String: Any]? {
        var data: [String: Any] = [:]
        
        switch self {
        case .signup(let user):
            if let userDict: [String: Any] = user.asDictionary() {
                data = userDict
                print(userDict)
            }
        case .login(let credentials):
            data["username"] = credentials.username
            data["password"] = credentials.password
        case .updatePassword(_ , let oldPassword, let newPassword):
            data["oldPassword"] = oldPassword
            data["newPassword"] = newPassword
        default:
            return nil
        }
        
        return data
    }
}
