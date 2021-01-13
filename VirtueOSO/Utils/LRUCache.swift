//
//  LRUCache.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 1/12/21.
//  Copyright © 2021 Heriberto Prieto. All rights reserved.
//

import Foundation

public class LRUCache<KeyType: Hashable & Equatable, ValueType> {
    
    // MARK: - Private Properties
    
    private var cacheMap: [KeyType: ValueType] = [:]
    private var cacheOrder: [KeyType] = []
    private let maxSize: Int
    
    @objc init(maxSize: Int) {
        self.maxSize = maxSize
        
        // TODO: NotificationCenter
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func didEnterBackground() {
        
        clear()
    }
    
    @objc
    func didReceiveMemoryWarning() {
        clear()
    }
    
    private func updateCacheOrder(key: KeyType) {
        cacheOrder = cacheOrder.filter { $0 != key }
        cacheOrder.append(key)
    }
    
    public func get(key: KeyType) -> ValueType? {
        guard let value = cacheMap[key] else {
            return nil
        }
        
        updateCacheOrder(key: key)
        
        return value
    }
    
    public func set(key: KeyType, value: ValueType) {
        cacheMap[key] = value
        
        while cacheOrder.count > maxSize {
            guard let staleKey = cacheOrder.first else {
                return
            }
            cacheOrder.removeFirst()
            cacheMap.removeValue(forKey: staleKey)
        }
    }
    
    @objc
    func clear() {
        cacheMap.removeAll()
        cacheOrder.removeAll()
    }
}
