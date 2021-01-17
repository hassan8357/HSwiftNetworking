//
//  NetworkErrorType.swift
//  NetworkingSwift
//
//  Created by Hassan Refaat on 11/7/19.
//

import Foundation

public enum APIErrorType {
    case apiError
    case invalidURL
    case invalidResponse
    case noData
    case decodeError
    case noInternet
    case custom
}

public struct NetworkError: Error {
    
    public var type: APIErrorType
    public var statusCode: Int?
    public var data: Data?
    public var customError: String?
    public var customErrorTitle: String?

    public init(type: APIErrorType = .custom,
                customError: String? = nil,
                customErrorTitle: String? = nil,
                statusCode: Int? = nil,
                data: Data? = nil) {
           self.type = type
           self.statusCode = statusCode
           self.data = data
           self.customError = customError
           self.customErrorTitle = customErrorTitle
    }
}
