//
//  JSON.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/28/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public struct JSON {
    /// A fallback DateFormatter when not on a platform that supports the
    /// `.ios8601` Date Encoding/Decoding Strategy.
    public static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    /// A shared `JSONEncoder` used across the framework, pre-configured with a
    /// `dateEncodingStrategy` to match API expectations.
    public static var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        if #available(OSX 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        } else {
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
        }
        return encoder
    }()
    
    /// A shared `JSONDecoder` used across the framework, pre-configured with a
    /// `dateDecodingStrategy` to match API expectations.
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        if #available(OSX 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        } else {
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
        }
        return decoder
    }()
    
    /// Attempt to decode a singular - or collection of - JSON Object(s)
    ///
    /// * When `T` is a singular object, `object` is expected to be **{}**
    /// * When `T` is a collection, `object` is exprected to be **[{}]**.
    public static func decode<T: Decodable>(object: Any?, ofType type: T.Type) -> T? {
        guard let dictionary = object as? [String: Any] else {
            return nil
        }
        
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        } catch {
            return nil
        }
        
        let t: T
        do {
            t = try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
        
        return t
    }
    
    /// Encodes an object(s) of type `T`.
    public static func encode<T: Encodable>(_ object: T) -> Data? {
        let data: Data
        do {
            data = try encoder.encode(object)
        } catch {
            return nil
        }
        return data
    }
    
    /// Uses `JSONSerialization` to create a dictionary representation of the provided `data`.
    public static func dictionary(from data: Data?) -> [String: Any]? {
        guard let data = data else {
            return nil
        }
        
        let object: Any
        do {
            object = try JSONSerialization.jsonObject(with: data, options: .init())
        } catch {
            print(error)
            return nil
        }
        
        guard let dictionary = object as? [String: Any] else {
            return nil
        }
        
        return dictionary
    }
    
    /// Uses `JSONSerialization` to create an array representation of the provided `data`.
    public static func array(from data: Data?) -> [[String: Any]]? {
        guard let data = data else {
            return nil
        }
        
        let object: Any
        do {
            object = try JSONSerialization.jsonObject(with: data, options: .init())
        } catch {
            print(error)
            return nil
        }
        
        guard let array = object as? [[String: Any]] else {
            return nil
        }
        
        return array
    }
    
    /// Uses `JSONSerialization` to create _any_ JSON object then re-serialize that
    /// object into a formatted JSON string.
    public static func json(from data: Data?, pretty: Bool = false) -> String? {
        guard let data = data else {
            return nil
        }
        
        var options: JSONSerialization.WritingOptions = .init()
        if #available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
            options.insert(.sortedKeys)
        }
        if pretty {
            options.insert(.prettyPrinted)
        }
        
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .init())
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: options)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
    
    /// Uses `JSONSerialization` to create a data representation of the provided dictionary.
    public static func data(from dictionary: [String: Any]?) -> Data? {
        guard let dictionary = dictionary else {
            return nil
        }
        
        var formattedDictionary: [String: Any] = dictionary
        
        for pair in dictionary {
            if let date = pair.value as? Date {
                formattedDictionary[pair.key] = JSON.dateFormatter.string(from: date)
            }
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: formattedDictionary, options: .init())
            return data
        } catch {
            print(error)
            return nil
        }
    }
}
