//
//  FriendListStore.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/11/2.
//

import Foundation
import ComposableArchitecture
import KKApi

public struct FriendListStore: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public var list: [Person]
        
        public init(list: [Person] = []) {
            self.list = list
        }
    }
    
    public enum Action {
        case configure([Person])
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .configure(person):
                state.list = person
                return .none
            }
        }
    }
}
