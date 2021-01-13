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
        request(type: User.self, from: endpoint, completionHandler: completionHandler)
    }
    
    /// `api/users/login`
    public func login(credentials: Credentials, completionHandler: @escaping UserCompletion) {
        let endpoint: Endpoint = AppEndpoint.login(credentials: credentials)
        request(type: User.self, from: endpoint, completionHandler: completionHandler)
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
    
    public func getUser(withId id: Int, completionHandler: @escaping UserCompletion) {
        let endpoint: Endpoint = AppEndpoint.getUser(id: id)
        request(type: User.self, from: endpoint, completionHandler: completionHandler)
    }
    
    public func updatePassword(forUserWithId id: Int, newPassword: String, oldPassword: String, completionHandler: @escaping TableStatusCompletion) {
        let endpoint: Endpoint = AppEndpoint.updatePassword(id: id, oldPassword: oldPassword, newPassword: newPassword)
        request(type: TableUpdateStatusModel.self, from: endpoint, completionHandler: completionHandler)
    }
    
    public func getFollowers(ofUserWithId id: Int, completionHandler: @escaping UsersCompletion) {
        let endpoint: Endpoint = AppEndpoint.userFollowers(id: id)
        request(type: [User].self, from: endpoint, completionHandler: completionHandler)
    }
    
    public func getUsersFollowedBy(userWithId id: Int, completionHandler: @escaping UsersCompletion) {
        let endpoint: Endpoint = AppEndpoint.userFollowing(id: id)
        request(type: [User].self, from: endpoint, completionHandler: completionHandler)
    }
    
    // TODO: Finish implementing dictionary completionHandler parameter type
    public func getUsernameAvailability(username: String, completionHandler: @escaping AvailabilityCompletion) {
        let endpoint: Endpoint = AppEndpoint.isUsernameAvailable(username: username)
        request(type: AvailabilityModel.self, from: endpoint, completionHandler: completionHandler)
    }
    
    // TODO: Finish implementing dictionary completionHandler parameter type
    public func getEmailAvailability(email: String, completionHandler: @escaping AvailabilityCompletion) {
        let endpoint: Endpoint = AppEndpoint.isEmailAvailable(email: email)
        request(type: AvailabilityModel.self, from: endpoint, completionHandler: completionHandler)
    }
    
    public func follow(userWithId id: Int, byId followerId: Int, completionHandler: @escaping TableStatusCompletion) {
        let endpoint: Endpoint = AppEndpoint.follow(followerId: followerId, userId: id)
        request(type: TableUpdateStatusModel.self, from: endpoint, completionHandler: completionHandler)
    }
    
    public func unfollow(userWithId id: Int, byId unfollowerId: Int, completionHandler: @escaping TableStatusCompletion) {
        let endpoint: Endpoint = AppEndpoint.unfollow(followerId: id, userId: unfollowerId)
        request(type: TableUpdateStatusModel.self, from: endpoint, completionHandler: completionHandler)
    }
}
