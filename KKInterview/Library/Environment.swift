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
    
    init(
        apiService: KKServiceProtocol = KKService(),
        currentUser: User? = nil
    ) {
        self.apiService = apiService
        self.currentUser = currentUser
    }
}
