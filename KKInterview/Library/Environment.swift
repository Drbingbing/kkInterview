//
//  Environment.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import KKLibrary
import Foundation

public struct Environment {
    
    /// A type that exposes endpoint for fetching kkinterview data.
    public let apiService: KKServiceProtocol
    
    /// The currently logged in user.
    public let currentUser: User?
    
    /// The current episode.
    public let episode: InterviewEpisode
    
    init(
        apiService: KKServiceProtocol = KKService(),
        currentUser: User? = nil,
        episode: InterviewEpisode = .episode1
    ) {
        self.apiService = apiService
        self.currentUser = currentUser
        self.episode = episode
    }
}
