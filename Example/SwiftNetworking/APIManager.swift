//
//  APIManager.swift
//  SwiftNetworking_Example
//
//  Created by Hassan Refaat on 2/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftNetworking

class APIManager: BaseAPIHandler {
    
    func getAllPosts(handler: @escaping CompletePostsOperation) {        
        let router = BaseRouter(method: .get, path: EndPoint.posts.rawValue, baseURLString: BaseURL)
        
        super.performNetworkRequest(forRouter: router, jsonDecoder: JSONDecoder(), then: handler)
    }
}
