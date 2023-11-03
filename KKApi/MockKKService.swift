//
//  MockKKService.swift
//  KKApi
//
//  Created by 鍾秉辰 on 2023/11/3.
//

import Foundation

public struct MockKKService: KKServiceProtocol {
    
    public let serverConfig: ServerConfigType
    
    public let userInfoResult: Result<UserEnvelope, Never>?
    
    public let loginResult: Result<User?, Never>?
    
    public let friendListResult: Result<[Person], Never>?
    
    public init(
        serverConfig: ServerConfigType = ServerConfig.production,
        userInfoResult: Result<UserEnvelope, Never>? = nil,
        loginResult: Result<User?, Never>?,
        friendListResult: Result<[Person], Never>?
    ) {
        self.serverConfig = serverConfig
        self.userInfoResult = userInfoResult
        self.friendListResult = friendListResult
        self.loginResult = loginResult
    }
    
    public init(serverConfig: ServerConfigType = ServerConfig.production) {
        self.serverConfig = serverConfig
        self.userInfoResult = nil
        self.friendListResult = nil
        self.loginResult = nil
    }
    
    public func userInfo() async throws -> UserEnvelope {
        return await withCheckedContinuation { continuation in
            if let userInfoResult {
                continuation.resume(with: userInfoResult)
            } else {
                continuation.resume(returning: UserEnvelope(users: []))
            }
        }
    }
    
    public func login() async throws -> User? {
        return await withCheckedContinuation { continuation in
            if let loginResult {
                continuation.resume(with: loginResult)
            } else {
                continuation.resume(returning: User(name: "Debug", kokoID: "koko_debug"))
            }
        }
    }
    
    public func friendList(page: Int) async throws -> [Person] {
        return await withCheckedContinuation { continuation in
            if let friendListResult {
                continuation.resume(with: friendListResult)
            } else {
                continuation.resume(returning: [])
            }
        }
    }
    
    
}
