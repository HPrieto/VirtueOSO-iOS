//
//  User.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public typealias UserCompletion = (Result<User, Swift.Error>) -> Void
public typealias UsersCompletion = (Result<[User], Swift.Error>) -> Void

public struct User: Codable, Equatable, Identifiable {
    
    public var id: String = UUID().uuidString
    public var token: String?
    public var username: String?
    public var password: String?
    public var firstName: String?
    public var lastName: String?
    public var preferredName: String?
    public var email: String?
    public var phoneNumber: String?
    public var dateOfBirth: Date?
    public var lastLogin: Date?
    public var createdDate: Date?
    
    public init() {
        
    }
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id = "id"
        case token = "token"
        case username = "username"
        case password = "password"
        case firstName = "firstName"
        case lastName = "lastName"
        case preferredName = "preferredName"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case dateOfBirth = "dateOfBirth"
        case lastLogin = "lastLogin"
        case createdDate = "createdDate"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        token = try values.decode(String.self, forKey: .token)
        username = try values.decode(String.self, forKey: .username)
        password = try values.decode(String.self, forKey: .password)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        preferredName = try values.decode(String.self, forKey: .preferredName)
        email = try values.decode(String.self, forKey: .email)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        dateOfBirth = try values.decode(String.self, forKey: .dateOfBirth).toJsonDate()
        lastLogin = try values.decode(String.self, forKey: .lastLogin).toJsonDate()
        createdDate = try values.decode(String.self, forKey: .createdDate).toJsonDate()
    }
}
