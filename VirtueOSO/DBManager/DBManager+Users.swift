//
//  DBManager+Users.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/29/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {
    
    // MARK: - Authentication
    
    /// `api/users/signup`
    public func signup(newUser: User, completionHandler: @escaping UserCompletion) {
        let endpoint: Endpoint = AppEndpoint.signup(user: newUser)
        request(type: User.self, from: endpoint) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let user):
                completionHandler(.success(user))
            }
        }
    }
    
    /// `api/users/login`
    public func login(credentials: Credentials, completionHandler: @escaping UserCompletion) {
        let endpoint: Endpoint = AppEndpoint.login(credentials: credentials)
        request(type: User.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let user):
                completionHandler(.success(user))
            }
        }
    }
    
    public func logout(credentials: Credentials, completionHandler: @escaping VoidCompletion) {
        let endpoint: Endpoint = AppEndpoint.logout
        request(type: String.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success:
                completionHandler(.success(()))
            }
        }
    }
    
    // MARK: - Users
    
    public func getAllUsers(completionHandler: @escaping UsersCompletion) {
        
    }
    
    public func get(userWithId id: Int, completionHandler: @escaping UserCompletion) {
        let endpoint: Endpoint = AppEndpoint.getUser(id: id)
        request(type: User.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let user):
                completionHandler(.success(user))
            }
        }
    }
    
    public func put(id: Int, updatePassword oldPassword: String, newPassword: String, completionHandler: @escaping TableStatusCompletion) {
        let endpoint: Endpoint = AppEndpoint.updatePassword(id: id, oldPassword: oldPassword, newPassword: newPassword)
        request(type: TableUpdateStatusModel.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let model):
                completionHandler(.success(model))
            }
        }
    }
    
    public func get(usersFollowingUserWithId id: Int, completionHandler: @escaping UsersCompletion) {
        let endpoint: Endpoint = AppEndpoint.userFollowers(id: id)
        request(type: [User].self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let followers):
                completionHandler(.success(followers))
            }
        }
    }
    
    public func get(usersFollowedByUserWithId id: Int, completionHandler: @escaping UsersCompletion) {
        let endpoint: Endpoint = AppEndpoint.userFollowing(id: id)
        request(type: [User].self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let followers):
                completionHandler(.success(followers))
            }
        }
    }
    
    // TODO: Finish implementing dictionary completionHandler parameter type
    public func isUsernameAvailable(username: String, completionHandler: @escaping GenericCompletion<[String: Any]>) {
        let endpoint: Endpoint = AppEndpoint.isUsernameAvailable(username: username)
        request(type: Data.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let model):
                if let dict: [String: Any] = model.asDictionary() {
                    completionHandler(.success(dict))
                } else {
                    completionHandler(.failure(NetworkServiceError.notFound))
                }
            }
        }
    }
    
    // TODO: Finish implementing dictionary completionHandler parameter type
    public func isEmailAvailable(email: String, completionHandler: @escaping GenericCompletion<[String: Any]>) {
        let endpoint: Endpoint = AppEndpoint.isEmailAvailable(email: email)
        request(type: Data.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let model):
                if let dict: [String: Any] = model.asDictionary() {
                    completionHandler(.success(dict))
                } else {
                    completionHandler(.failure(NetworkServiceError.notFound))
                }
            }
        }
    }
    
    public func post(id: Int, followerUserWithId followId: Int, completionHandler: @escaping TableStatusCompletion) {
        let endpoint: Endpoint = AppEndpoint.follow(followerId: id, userId: followId)
        request(type: TableUpdateStatusModel.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let followers):
                completionHandler(.success(followers))
            }
        }
    }
    
    public func delete(id: Int, unfollowUserWithId unfollowId: Int, completionHandler: @escaping TableStatusCompletion) {
        let endpoint: Endpoint = AppEndpoint.unfollow(followerId: id, userId: unfollowId)
        request(type: TableUpdateStatusModel.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let followers):
                completionHandler(.success(followers))
            }
        }
    }
}
