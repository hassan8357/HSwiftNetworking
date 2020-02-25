//
//  NetworkClient.swift
//  Pods
//
//  Created by Patrick on 4/4/17.
//
//

import Foundation

/// Abstract networking client.
public class NetworkClient {
    typealias JSONDictionary = [String: Any]
    
    // MARK: - Types
    
    enum Method: String {
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case connect = "CONNECT"
        case options = "OPTIONS"
        case trace = "TRACE"
        case patch = "PATCH"
        
        var acceptsBody: Bool {
            switch self {
            case .post, .put, .patch:
                return true
            default:
                return false
            }
        }
    }
    
    enum Error: Swift.Error {
        case unknown
    }
    
    // MARK: - Properties
    
    public let baseURL: URL
    public let session: URLSession
    
    // MARK: - Initializers
    
    public init(baseURL: URL, session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    // MARK: - Requests
    
    /// Build a URLRequest based on the baseURL of the NetworkClient.
    ///
    /// - parameter method: HTTP method
    /// - parameter path: path component
    /// - parameter queryItems: optional array of query items
    /// - parameter parameters: optional JSONDictionary of params
    /// - returns: Expected URLRequest
    func buildRequest(method: Method = .get, path: String, queryItems: [URLQueryItem] = [], parameters: JSONDictionary? = nil) -> URLRequest {
        // Create url with path component
        var url = baseURL.appendingPathComponent(path)
        
        // Apply query parameters to url
        if !queryItems.isEmpty, var components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            components.queryItems = queryItems
            
            if let modifiedURL = components.url {
                url = modifiedURL
            }
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Add defaults
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        
        // Add body
        if let parameters = parameters, method.acceptsBody, let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = body
        }
        
        return request
        
    }
    
    /// Build and send a URLRequest (raw network result)
    ///
    /// - parameter method: HTTP method
    /// - parameter path: path component
    /// - parameter queryItems: optional array of query items
    /// - parameter parameters: optional JSONDictionary of params
    /// - parameter completion: completion block called containing a Result object
    func request(method: Method = .get, path: String, queryItems: [URLQueryItem] = [], parameters: JSONDictionary? = nil, completion:  ((NetworkResult) -> Void)? = nil) {
        // Make request
        let request = buildRequest(method: method, path: path, queryItems: queryItems, parameters: parameters)
        
        // Send request
        session.dataTask(with: request) { (data, response, error) in
            // Success
            if let response = response {
                completion?(.success(response, data))
                return
            }

            // Failure
            completion?(.failure(error ?? Error.unknown))
        }.resume()
    }
}












