//
//  PostModel.swift
//  SwiftNetworking_Example
//
//  Created by Hassan Refaat on 2/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    
    var userId: Int
    var id: Int
    var title: String
    var body: String

    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}
