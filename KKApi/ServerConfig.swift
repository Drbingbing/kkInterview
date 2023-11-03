//
//  ServerConfig.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/10/31.
//

import Foundation

public protocol ServerConfigType {
    var apiBaseUrl: URL { get }
}

public struct ServerConfig: ServerConfigType {
    
    public var apiBaseUrl: URL
    
    public static let production: ServerConfigType = ServerConfig(
        apiBaseUrl: URL(string: "https://dimanyen.github.io")!
    )
    
    public static let development: ServerConfigType = ServerConfig(
        apiBaseUrl: URL(string: "https://github.io")!
    )
}

public func == (lhs: ServerConfigType, rhs: ServerConfigType) -> Bool {
    return type(of: lhs) == type(of: rhs) && lhs.apiBaseUrl == rhs.apiBaseUrl
}
