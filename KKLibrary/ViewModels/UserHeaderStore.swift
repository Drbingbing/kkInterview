//
//  UserHeaderStore.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/11/2.
//

import Foundation
import ComposableArchitecture
import KKApi

public struct UserHeaderStore: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public var user: User?
        
        public init(user: User? = nil) {
            self.user = user
        }
    }
    
    public enum Action {
        case configure(User?)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .configure(user):
                state.user = user
                return .none
            }
        }
    }
}
