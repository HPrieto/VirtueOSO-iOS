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
                completionHandler(.failure(error))
                return
            }
            
            guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkServiceError.notFound))
                return
            }
            
            guard
                let data: Data = data,
                response.statusCode == 200
            else {
                completionHandler(.failure(NSError(domain: response.description, code: response.statusCode, userInfo: nil) as Error))
                return
            }
            print(baseURLString, String(data: data, encoding: .utf8), "statusCode: \(response.statusCode)")
            do {
                let models = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(models))
            } catch let err {
                completionHandler(.failure(err))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Authentication
    
    public func login(credentials: Credentials, completionHandler: @escaping UserCompletion) {
        let endpoint: Endpoint = AppEndpoint.login(credentials: credentials)
        request(type: User.self, from: endpoint) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let user):
                completionHandler(.success(user))
            }
        }
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
}
