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
            if let _ = error {
                result(.failure(NetworkError()))
                return
            }
            guard let response = response, let data = data else {
                let error = NetworkError()
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
    
    func uploadTask(with request: URLRequest, from bodyData: Data, result: @escaping BaseAPIHandler.DataHandler) -> URLSessionUploadTask {
        return uploadTask(with: request, from: bodyData) { (data, response, error) in
            if let _ = error {
                result(.failure(NetworkError()))
                return
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
