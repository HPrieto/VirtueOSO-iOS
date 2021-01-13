//
//  DBManager.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

// MARK: - Completion

public typealias VoidCompletion = (Result<Void, Swift.Error>) -> Void
public typealias StringCompletion = (Result<String, Swift.Error>) -> Void
public typealias StringsCompletion = (Result<[String], Swift.Error>) -> Void
public typealias GenericCompletion<T> = (Result<T, Swift.Error>) -> Void
public typealias AnyDecodable = Any & Decodable
public typealias SuccessCompletion = (Bool) -> Void

// MARK: - DBManager

class DBManager {
    
    public static let shared: DBManager = DBManager()
}

// MARK: - GET

extension DBManager {
    
    public func request<T: Decodable>(type: T.Type, from endpoint: Endpoint, completionHandler: @escaping (Swift.Result<T, Swift.Error>) -> Void) {
        guard
            let baseURLString: String = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String,
            let baseURL: URL = URL(string: baseURLString)
        else {
            completionHandler(.failure(NetworkServiceError.url))
            return
        }
        
        var request: URLRequest
        do {
            request = try endpoint.urlRequest(using: baseURL)
        } catch {
            completionHandler(.failure(error))
            return
        }
        
        let sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: sessionConfig)
        let dataTask: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            guard
                let response: HTTPURLResponse = response as? HTTPURLResponse,
                let data = data
            else {
                DispatchQueue.main.async {
                    completionHandler(.failure(NetworkServiceError.notFound))
                }
                return
            }
            print("Response Data:", String(data: data, encoding: .utf8) ?? "None")
            do {
                let res = try JSONDecoder().decode(APIResponse<T>.self, from: data)
                if let data = res.data {
                    DispatchQueue.main.async {
                        completionHandler(.success(data))
                    }
                } else if let apiError = res.error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(apiError.toError()))
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(NSError(domain: response.description, code: response.statusCode, userInfo: nil) as Error))
                    }
                }
            } catch let err {
                print(err)
                DispatchQueue.main.async {
                    completionHandler(.failure(err))
                }
            }
        }
        dataTask.resume()
    }
}
