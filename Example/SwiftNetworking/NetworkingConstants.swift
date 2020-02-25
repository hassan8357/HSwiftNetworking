//
//  NetworkingConstants.swift
//  SwiftNetworking_Example
//
//  Created by Hassan Refaat on 2/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftNetworking

let BaseURL = "https://jsonplaceholder.typicode.com/"

typealias CompletePostsOperation = (Result<[PostModel], NetworkError>) -> ()
