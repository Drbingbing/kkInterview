//
//  KKServiceProtocol.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/10/31.
//

import Foundation

public protocol KKServiceProtocol {
    var serverConfig: ServerConfigType { get }
    
    init(serverConfig: ServerConfigType)
    
    func userInfo() async throws -> UserEnvelope
    
    func login() async throws -> User?
    
    func friendList(page: Int) async throws -> [Person]
}

public func == (lhs: KKServiceProtocol, rhs: KKServiceProtocol) -> Bool {
    return type(of: lhs) == type(of: rhs) && lhs.serverConfig == rhs.serverConfig
}

public func != (lhs: KKServiceProtocol, rhs: KKServiceProtocol) -> Bool {
    return !(lhs == rhs)
}

