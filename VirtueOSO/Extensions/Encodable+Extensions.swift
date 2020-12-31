//
//  Encodable+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/28/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public extension Encodable {
    /// Uses a `JSONEncoder` to encode the object, producing a `Data` representation.
    func asData() -> Data? {
        return JSON.encode(self)
    }
    
    /// A dictionary representation of the Encodable object.
    func asDictionary() -> [String: Any]? {
        return JSON.dictionary(from: asData())
    }
    
    /// An array representation of the Encodable object.
    func asArray() -> [[String: Any]]? {
        return JSON.array(from: asData())
    }
    
    /// A JSON string representation
    func asJSON() -> String? {
        return JSON.json(from: asData(), pretty: false)
    }
    
    /// A _pretty_ JSON representation
    func asPrettyJSON() -> String? {
        return JSON.json(from: asData(), pretty: true)
    }
}
