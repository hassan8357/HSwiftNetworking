[![Build Status](https://travis-ci.org/patrickmontalto/SwiftNetworking.svg?branch=master)](https://travis-ci.org/patrickmontalto/SwiftNetworking) [![Version](https://img.shields.io/cocoapods/v/SwiftNetworking.svg?style=flat)](http://cocoapods.org/pods/SwiftNetworking) [![License](https://img.shields.io/cocoapods/l/SwiftNetworking.svg?style=flat)](http://cocoapods.org/pods/SwiftNetworking) [![Platform](https://img.shields.io/cocoapods/p/SwiftNetworking.svg?style=flat)](http://cocoapods.org/pods/SwiftNetworking)

## Overview

Provides a lightweight and simple NetworkClient to build and intiate URLRequests in Swift.

## Requirements

- iOS 8.0 + / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.1+
- Swift 3.0+
 
## Installation

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

`$ gem install cocoapods`

To integrate SwiftNetworking into your Xcode project using Cocoapods, specify it in your `Podfile`:

``` ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SwiftNetworking'
end
```
Then, run the following command:

`$ pod install`

## Usage

### Creating a Request

Initialize a NetworkClient object with a baseURL. You may also include a custom session (defaults to URLSession.shared).

``` swift
import SwiftNetworking

let baseURL = URL(string: "http://example.com/api/v1")!
let client = NetworkClient(baseURL: baseURL)
let request = client.buildRequest(method: .get, path: "me")
```
### Initiating a request

``` swift
let client = NetworkClient(baseURL: baseURL)
client.request(path: "me")
```
You may also provide a completion handler. An enum `Result<Element>` serves to contain the success and failure cases of a network request response.
The completion handler is of type `(NetworkResult) -> Void`, where  `NetworkResult` is a `typealias` of `Result<(URLResponse, Data?)>`.

``` swift
client.request(path: "me") { (result) in
    switch result {
    case .success(let response, let data):
        // Handle success
    case .failure(let error):
        // Handle failure
    }
}
```
## Author

pmontalto@gmail.com

## License

SwiftNetworking is available under the MIT license. See the LICENSE file for more info.