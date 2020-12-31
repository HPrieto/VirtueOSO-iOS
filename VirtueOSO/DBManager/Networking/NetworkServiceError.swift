//
//  NetworkServiceError.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

public enum NetworkServiceError: Error, Equatable, CaseIterable {
    case url
    case offline
    case responseTimeout
    case gatewayTimeout
    case serviceUnavailable
    case internalServerError
    case conflict
    case notFound
    case credentials
    
    // MARK: - Init
    
    public init?(statusCode: Int?) {
        guard let statusCode: Int = statusCode else {
            return nil
        }
        
        for enumCase in NetworkServiceError.allCases {
            if enumCase.statusCode == statusCode {
                self = enumCase
                return
            }
        }
        return nil
    }
    
    // MARK: - StatusCode
    public var statusCode: Int {
        switch self {
        case .url:
            return NSURLErrorBadURL
        case .offline:
            return NSURLErrorNotConnectedToInternet
        case .responseTimeout:
            return NSURLErrorTimedOut
        case .gatewayTimeout:
            return 504
        case .serviceUnavailable:
            return 503
        case .internalServerError:
            return 500
        case .conflict:
            return 409
        case .notFound:
            return 404
        case .credentials:
            return 401
        }
    }
    
    // MARK: - Compare
    
    public static func == (lhs: NetworkServiceError, rhs: NetworkServiceError) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
}
