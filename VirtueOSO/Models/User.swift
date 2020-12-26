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
    public var email: String?
    public var description: String?
    public var phoneNumber: String?
    public var birthDate: Date?
    public var lastLoginTime: Date?
    public var createTime: Date?
    public var deleteTime: Date?
    public var updateTime: Date?
    public var tokenExpireTime: Date?
    public var timeZone: String?
    public var regionCode: String?
    public var languageCode: String?
    public var imageUrl: String?
    public var isActive: Bool?
    
    public init() {
        
    }
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id = "id"
        case token = "token"
        case username = "username"
        case password = "password"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case description = "description"
        case phoneNumber = "phoneNumber"
        case birthDate = "birthDate"
        case lastLoginTime = "lastLoginTime"
        case createTime = "createTime"
        case deleteTime = "deleteTime"
        case updateTime = "updateTime"
        case tokenExpireTime = "tokenExpireTime"
        case timeZone = "timeZone"
        case regionCode = "regionCode"
        case languageCode = "languageCode"
        case imageUrl = "imageUrl"
        case isActive = "isActive"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        token = try values.decode(String.self, forKey: .token)
        username = try values.decode(String.self, forKey: .username)
        password = try values.decode(String.self, forKey: .password)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        email = try values.decode(String.self, forKey: .email)
        description = try values.decode(String.self, forKey: .description)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        birthDate = try values.decode(String.self, forKey: .birthDate).toJsonDate()
        lastLoginTime = try values.decode(String.self, forKey: .lastLoginTime).toJsonDate()
        createTime = try values.decode(String.self, forKey: .createTime).toJsonDate()
        deleteTime = try values.decode(String.self, forKey: .deleteTime).toJsonDate()
        updateTime = try values.decode(String.self, forKey: .updateTime).toJsonDate()
        tokenExpireTime = try values.decode(String.self, forKey: .tokenExpireTime).toJsonDate()
        timeZone = try values.decode(String.self, forKey: .timeZone)
        regionCode = try values.decode(String.self, forKey: .regionCode)
        languageCode = try values.decode(String.self, forKey: .languageCode)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        isActive = try values.decode(Int.self, forKey: .isActive) == 1 ? true : false
    }
}
