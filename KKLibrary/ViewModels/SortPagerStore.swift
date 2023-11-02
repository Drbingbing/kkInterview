//
//  SortPagerStore.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/11/2.
//

import Foundation
import ComposableArchitecture
import KKApi

public struct SortPagerStore: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public var sorts: [SortPagerParams]
        public var selectedPage: Int? = nil
        
        public init(sorts: [SortPagerParams] = [], selectedPage: Int? = nil) {
            self.sorts = sorts
            self.selectedPage = selectedPage
        }
    }
    
    public enum Action {
        case configure([SortPagerParams])
        case didSelectPageAt(Int)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .configure(sorts):
                state.sorts = sorts
                return .none
            case let .didSelectPageAt(page):
                state.selectedPage = page
                return .none
            }
        }
    }
}
