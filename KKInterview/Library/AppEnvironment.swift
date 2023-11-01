//
//  AppEnvironment.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation
import KKLibrary

struct AppEnvironment {
    
    fileprivate static var stack: [Environment] = [Environment()]
    
    // The most recent environment on the stack.
    static var current: Environment! {
        return stack.last
    }
    
    static func updateCurrentUser(_ user: User) {
        replaceCurrentEnvironment(currentUser: user)
    }
    
    static func replaceCurrentEnvironment(
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
    
    static func replaceCurrentEnvironment(_ env: Environment) {
        pushEnvironment(env)
        stack.remove(at: stack.count - 2)
    }
    
    /// Push a new environment onto the stack
    static func pushEnvironment(_ env: Environment) {
        stack.append(env)
    }
}
