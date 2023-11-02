//
//  FreindListCellStore.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/11/2.
//

import Foundation
import ComposableArchitecture
import KKApi

public struct FreindListCellStore: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        public var name: String
        public var isTop: Bool
        public var status: Int
        
        public init(name: String = "", isTop: Bool = false, status: Int = 0) {
            self.name = name
            self.isTop = isTop
            self.status = status
        }
    }
    
    public enum Action {
        case populate(Person)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .populate(person):
                state.isTop = person.isTop
                state.name = person.name
                state.status = person.status
                return .none
            }
        }
    }
}
