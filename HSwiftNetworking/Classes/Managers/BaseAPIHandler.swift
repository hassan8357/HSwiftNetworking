//
//  BaseAPIHandler.swift
//  Vezeeta
//
//  Created by Hassan on 2/10/19.
//  Copyright © 2019 Hassan. All rights reserved.
//

import Foundation

open class BaseAPIHandler : NSObject {
    
    typealias DataHandler = (Result<(URLResponse, Data), NetworkError>) -> Void

    /// This method perform network request and complete with URLResponse & Data in success case
    private func performRequest(forRouter router: BaseRouter, then handler: @escaping DataHandler) {
        
        printRequest(forRouter: router)
        
        if !Reachability.isConnectedToNetwork {
            handler(.failure(NetworkError(type: .noInternet)))
        }
        
        do {
            let request = try router.asURLRequest()
            if router.isMultiPart {
                URLSession.shared.uploadTask(with: request, from: router.multiPartData(), result: handler).resume()
            }
            else {
                URLSession.shared.dataTask(with: request, result: handler).resume()
            }
        } catch {
            print("Can't get router.asURLRequest")
            handler(.failure(NetworkError(type: .invalidURL)))
        }
    }
    
    /// This method perform network request and complete with JSON in success case
    public func performNetworkRequest(forRouter router: BaseRouter, then handler: @escaping (Result<Any, NetworkError>) -> Void) {
        performRequest(forRouter: router) { (result) in
            switch result {
            case .success((let response, let data)):
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    //Handle HTTP errors here
                    guard 200..<299 ~= statusCode else {
                        handler(.failure(NetworkError(type: .invalidResponse, statusCode: statusCode, data: data)))
                        return
                    }
                    do {
                        if data.count > 0 {
                            //Handle json response
                            let json = try JSONSerialization.jsonObject(with: data)
                            handler(.success(json))
                        }
                        else {
                            handler(.success([:]))
                        }

                    } catch {
                        //JSONSerialization catch error
                        handler(.failure(NetworkError(type: .noData)))
                    }
                }
                else {
                    //Can't get status code
                    handler(.failure(NetworkError(type: .invalidResponse)))
                }
                break
            
            case .failure(let error):
                //API error
                handler(.failure(error))
                break
            }
        }
    }
    
    /// This method perform network request and complete with Decodable Type in success case
    public func performNetworkRequest<T: Decodable>(forRouter router: BaseRouter, jsonDecoder: JSONDecoder, then handler: @escaping (Result<T, NetworkError>) -> Void) {
        performRequest(forRouter: router) { (result) in
            switch result {
            case .success((let response, let data)):
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    //Handle HTTP errors here
                    guard 200..<299 ~= statusCode else {
                        handler(.failure(NetworkError(type: .invalidResponse, statusCode: statusCode, data: data)))
                        return
                    }
                    do {
                        //Handle Decoder
                        let values = try jsonDecoder.decode(T.self, from: data)
    
                        handler(.success(values))
                    } catch {
                        //decode catch error
                        handler(.failure(NetworkError(type: .decodeError)))
                    }
                }
                else {
                    //Can't get status code
                    handler(.failure(NetworkError(type: .invalidResponse)))
                }
                break
                
            case .failure(let error):
                //API error
                handler(.failure(error))
                break
            }
        }
    }
    
    // MARK:- Helper
    private func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String{
        
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        if JSONSerialization.isValidJSONObject(value) {
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }
            catch {
                print("error")
            }
            
        }
        return ""
    }
    
    private func printRequest(forRouter router: BaseRouter) {
        
        let headers = self.JSONStringify(value: router.requestHeaders as AnyObject, prettyPrinted: true)
        print("Request Headers:\n" + headers)  // Request Headers

        if let queryParameters = router.queryParameters {
            print("Query Parameters:\n" + self.JSONStringify(value: queryParameters as AnyObject, prettyPrinted: true))
        }
        
        if let bodyParameters = router.bodyParameters {
            print("Body JSON Parameters:\n" + self.JSONStringify(value: bodyParameters as AnyObject, prettyPrinted: true))
        }
        
        if let bodyArrayParameters = router.bodyArrayParameters {
            print("Body Array Parameters:\n" + self.JSONStringify(value: bodyArrayParameters as AnyObject, prettyPrinted: true))
        }
    }
}
