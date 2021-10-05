//
//  URLRequestEx.swift
//  HSwiftNetworking
//
//  Created by Vezeeta on 05/10/2021.
//

import Foundation

extension URLRequest {
    
    /// Percent escape
    ///
    /// Percent escape in conformance with W3C HTML spec:
    ///
    /// See http://www.w3.org/TR/html5/forms.html#application/x-www-form-urlencoded-encoding-algorithm
    ///
    /// - parameter string:   The string to be percent escaped.
    /// - returns:            Returns percent-escaped string.
    
    private func percentEscapeString(string: String) -> String {
        let characterSet: CharacterSet =
            .alphanumerics.union(.init(charactersIn: "-._* ")) // as per RFC 3986
        
        return (string.addingPercentEncoding(withAllowedCharacters: characterSet)?.replacingOccurrences(of: " ", with: "+"))!
    }
    
    /// Encode the parameters for `application/x-www-form-urlencoded` request
    ///
    /// - parameter parameters:   A dictionary of string values to be encoded in POST request
    
    mutating func encodeParameters(parameters: JSONDictionary) {
        let parameterArray = parameters.map { (key, value) -> String in
            let valueStr = (value as? String) ?? String(describing: value)
            return "\(key)=\(self.percentEscapeString(string: valueStr))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: .utf8)
    }
}
