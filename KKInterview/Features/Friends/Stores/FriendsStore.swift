//
//  FriendsStore.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation
import ComposableArchitecture
import KKLibrary

struct FriendsStore: Reducer {
    
    private var episode: InterviewEpisode
    
    init(episode: InterviewEpisode) {
        self.episode = episode
    }
    
    struct State: Equatable {
        var currentUser: User?
        var friendList: [Person] = []
        var invitations: [Person] = []
        var showKeyboard: Bool = false
        var filterList: [Person]? = nil
        var isRefreshing: Bool = false
        var isCollapse: Bool = false
    }
    
    enum Action {
        case currentUserUpdated
        case viewDidLoad
        case friendListResponse(TaskResult<[Person]>)
        case searchBarBeginEditing
        case searchBarEndEditing
        case searchTextChanged(String)
        case refresh
        case invitationTapped(Person)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .currentUserUpdated:
                state.currentUser = AppEnvironment.current.currentUser
                return .none
            case .viewDidLoad:
                switch episode {
                case .episode1:
                    return .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 4) })) }
                case .episode2:
                    return .concatenate(
                        .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 1) })) },
                        .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 2) })) }
                    )
                case .episode3:
                    return .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 3) })) }
                }
                
            case let .friendListResponse(.success(person)):
                switch episode {
                case .episode1, .episode2:
                    let merged = mergePersons(previous: state.friendList, new: person)
                    state.friendList = merged
                    state.isRefreshing = false
                case .episode3:
                    let merged = mergePersons(previous: state.friendList, new: person)
                    state.friendList = merged.filter { $0.status != 0 }
                    state.invitations = merged.filter { $0.status == 0 }
                    state.isRefreshing = false
                }
                return .none
            case .friendListResponse(.failure):
                state.isRefreshing = false
                return .none
            case .searchBarBeginEditing:
                state.showKeyboard = true
                return .none
            case .searchBarEndEditing:
                state.showKeyboard = false
                return .none
            case let .searchTextChanged(query):
                if query.isEmpty {
                    state.filterList = nil
                } else {
                    let filtered = state.friendList.filter { $0.name.contains(query) }
                    state.filterList = filtered
                }
                return .none
            case .refresh:
                state.filterList = nil
                state.friendList = []
                state.isRefreshing = true
                return .send(.viewDidLoad)
            case .invitationTapped:
                state.isCollapse.toggle()
                return .none
            }
        }
    }
    
    
    private func mergePersons(previous previousPerson: [Person], new newPerson: [Person]) -> [Person] {

        let result = previousPerson.merge(newPerson, on: { $0.fid == $1.fid }) { a, b in
            guard let first = Int(a.updateDate.replacingOccurrences(of: "/", with: "")),
                  let last = Int(b.updateDate.replacingOccurrences(of: "/", with: "")) else {
                return a
            }
            
            return first < last ? b : a
        }
        
        return result
    }
    
}
