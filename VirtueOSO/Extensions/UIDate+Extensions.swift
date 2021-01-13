//
//  UIDate+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/31/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension Date {
    
    public func toString(withDateFormat dateFormat: String = "MM-dd-yyyy HH:mm:ss") -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    public func toJsonString() -> String {
        return toString(withDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    static func -(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
}

extension String {
    
    public func toJsonDate() -> Date? {
        return JSON.dateFormatter.date(from: self)
    }
}
