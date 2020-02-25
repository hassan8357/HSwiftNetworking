//
//  Result.swift
//  Pods
//
//  Created by Patrick on 4/4/17.
//
//

public enum Result<Element> {
    case success(Element)
    case failure(Error)
}

public typealias NetworkResult = Result<(URLResponse, Data?)>
