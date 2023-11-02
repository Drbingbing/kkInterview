//
//  NewInvitationStore.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/11/3.
//

import Foundation
import KKApi
import ComposableArchitecture

public struct NewInvitationStore: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public var invitations: [Person]
        public var isStacked: Bool
        public init(invitations: [Person] = [], isStacked: Bool = true) {
            self.invitations = invitations
            self.isStacked = isStacked
        }
    }
    
    public enum Action {
        case configure([Person], stacked: Bool)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .configure(person, stacked):
                state.invitations = person
                state.isStacked = stacked
                return .none
            }
        }
    }
}
