//
//  Encodable+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/28/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public typealias EncodableCompletion = (Encodable?) -> Void
public typealias EncodablesCompletion = ([Encodable]?) -> Void

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

extension Encodable where Self: Identifiable {
    
    public var typeName: String {
        String(describing: Self.self)
    }
    
    public var fileName: String {
        "\(typeName)-\(id).cache"
    }
    
    public var fileURL: URL {
        let folderURLs = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        return folderURLs[0].appendingPathComponent(fileName)
    }
    
    func cacheOnDisk(using encoder: JSONEncoder = .init()) throws {
        let data = try encoder.encode(self)
        try data.write(to: fileURL)
    }
    
    func removeFromDisk(_ completionHandler: SuccessCompletion? = nil) {
        do {
            try FileManager.default.removeItem(at: fileURL)
            completionHandler?(true)
        } catch {
            completionHandler?(false)
        }
    }
    
    func getFromDisk(completionHandler: EncodableCompletion) {
        
        do {
            let data = try Data(contentsOf: fileURL) as? Self
            completionHandler(data)
        } catch {
            completionHandler(nil)
        }
    }
    
    func getAllFromDisk(_ completionHandler: EncodablesCompletion) {
        let folderURLs = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        guard let files = try? FileManager.default.contentsOfDirectory(
                at: folderURLs[0],
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles) else {
            completionHandler(nil)
            return
        }
        completionHandler(
            files.filter { $0.pathExtension == typeName }
        )
    }
}
