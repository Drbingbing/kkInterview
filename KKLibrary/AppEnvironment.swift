//
//  AppEnvironment.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation
import KKApi

public struct AppEnvironment {
    
    fileprivate static var stack: [Environment] = [Environment()]
    
    // The most recent environment on the stack.
    public static var current: Environment! {
        return stack.last
    }
    
    public static func updateCurrentUser(_ user: User) {
        replaceCurrentEnvironment(currentUser: user)
    }
    
    public static func updateServerConfig(_ config: ServerConfigType) {
        let service = KKService(serverConfig: config)
        replaceCurrentEnvironment(apiService: service)
    }
    
    public static func replaceCurrentEnvironment(
        apiService: KKServiceProtocol = AppEnvironment.current.apiService,
        currentUser: User? = AppEnvironment.current.currentUser,
        episode: InterviewEpisode = AppEnvironment.current.episode
    ) {
        replaceCurrentEnvironment(
            Environment(
                apiService: apiService, 
                currentUser: currentUser,
                episode: episode
            )
        )
    }
    
    public static func replaceCurrentEnvironment(_ env: Environment) {
        pushEnvironment(env)
        stack.remove(at: stack.count - 2)
    }
    
    /// Push a new environment onto the stack
    public static func pushEnvironment(_ env: Environment) {
        stack.append(env)
    }
    
    public static func pushEnvironment(
        apiService: KKServiceProtocol = AppEnvironment.current.apiService,
        currentUser: User? = AppEnvironment.current.currentUser,
        episode: InterviewEpisode = AppEnvironment.current.episode
    ) {
        pushEnvironment(
            Environment(
                apiService: apiService,
                currentUser: currentUser,
                episode: episode
            )
        )
    }
    
    @discardableResult
    public static func popEnvironment() -> Environment? {
        return stack.popLast()
    }
}
