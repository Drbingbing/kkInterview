//
//  KKService.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/10/31.
//

import Foundation

public struct KKService: KKServiceProtocol {
    
    public let serverConfig: ServerConfigType
    let monitor: ServiceMonitor
    
    public init(serverConfig: ServerConfigType = ServerConfig.production) {
        self.serverConfig = serverConfig
        self.monitor = CompositeServiceMonitor(monitors: [KKServiceMonitor()])
    }
    
    public func userInfo() async throws -> UserEnvelope {
        try await request(.userInfo)
    }
    
    public func login() async throws -> User? {
        let envelope = try await userInfo()
        return envelope.users.first
    }
    
    public func friendList(page: Int) async throws -> [Person] {
        let envelope: PersonEnvelope = try await request(.friend(page: page))
        return envelope.response
    }
}
