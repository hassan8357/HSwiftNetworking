//
//  URLSessionEx.swift
//  NetworkingSwift
//
//  Created by Hassan Refaat on 11/11/19.
//

import Foundation

extension URLSession {
    func dataTask(with url: URLRequest, result: @escaping BaseAPIHandler.DataHandler) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                var networkError = (error as? NetworkError) ?? NetworkError()
                if let data = data {
                    networkError.data = data
                }
                return result(.failure(networkError))
            }
            guard let response = response, let data = data else {
                let error = NetworkError()
                return result(.failure(error))
            }
            result(.success((response, data)))
        }
    }
    
    func uploadTask(with request: URLRequest, from bodyData: Data, result: @escaping BaseAPIHandler.DataHandler) -> URLSessionUploadTask {
        return uploadTask(with: request, from: bodyData) { (data, response, error) in
            if let error = error {
                var networkError = (error as? NetworkError) ?? NetworkError()
                if let data = data {
                    networkError.data = data
                }
                return result(.failure(networkError))
            }
            guard let response = response, let data = data else {
                let error = NetworkError()
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
