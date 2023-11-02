//
//  SortPagerCellStore.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/11/2.
//

import Foundation
import ComposableArchitecture

public struct SortPagerCellStore: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public var title: String
        public var number: Int
        
        public init(title: String = "", number: Int = 0) {
            self.title = title
            self.number = number
        }
    }
    
    public enum Action {
        case populate(SortPagerParams)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .populate(params):
                state.number = params.badgeNumber
                state.title = params.title
                return .none
            }
        }
    }
}
