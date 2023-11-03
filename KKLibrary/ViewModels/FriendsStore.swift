//
//  FriendsStore.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation
import ComposableArchitecture
import KKApi

public struct FriendsStore: Reducer {
    
    private var episode: InterviewEpisode
    
    public init(episode: InterviewEpisode) {
        self.episode = episode
    }
    
    public struct State: Equatable {
        public var currentUser: User?
        public var friendList: [Person] = []
        public var invitations: [Person] = []
        public var showKeyboard: Bool = false
        public var filterList: [Person]? = nil
        public var isRefreshing: Bool = false
        public var isStacked: Bool = true
        public var sorts: [SortPagerParams] = []
        public var disableSearchbar: Bool = false
        public var searchText: String? = nil
        public var navigateToAddContact: Bool = false
        
        public init() {}
    }
    
    public enum Action {
        case currentUserUpdated
        case viewDidLoad
        case friendListResponse(TaskResult<[Person]>)
        case searchBarBeginEditing
        case searchBarEndEditing
        case searchTextChanged(String)
        case refresh
        case invitationTapped(Person)
        case createSortButtons
        case didATMButtonTapped
        case closeContactButtonTapped
        case popViewController
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .currentUserUpdated:
                state.currentUser = AppEnvironment.current.currentUser
                return .none
            case .viewDidLoad:
                switch episode {
                case .episode1:
                    return .merge(
                        .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 4) })) },
                        .send(.createSortButtons)
                    )
                case .episode2:
                    return .merge(
                        .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 1) })) },
                        .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 2) })) },
                        .send(.createSortButtons)
                    )
                case .episode3:
                    return .merge(
                        .run { await $0(.friendListResponse(TaskResult { try await AppEnvironment.current.apiService.friendList(page: 3) })) },
                        .send(.createSortButtons)
                    )
                }
                
            case let .friendListResponse(.success(person)):
                switch episode {
                case .episode1:
                    let merged = mergePersons(previous: state.friendList, new: person)
                    state.friendList = merged
                    state.isRefreshing = false
                    state.sorts = [
                        SortPagerParams(title: "好友", badgeNumber: merged.filter({ $0.status == 2 }).count ),
                        SortPagerParams(title: "聊天", badgeNumber: 100)
                    ]
                    state.disableSearchbar = true
                case .episode2:
                    let merged = mergePersons(previous: state.friendList, new: person)
                    state.friendList = merged
                    state.isRefreshing = false
                    state.sorts = [
                        SortPagerParams(title: "好友", badgeNumber: merged.filter({ $0.status == 2 }).count ),
                        SortPagerParams(title: "聊天", badgeNumber: 100)
                    ]
                case .episode3:
                    let merged = mergePersons(previous: state.friendList, new: person)
                    state.friendList = merged.filter { $0.status != 0 }
                    state.invitations = merged.filter { $0.status == 0 }
                    state.isRefreshing = false
                    state.sorts = [
                        SortPagerParams(title: "好友", badgeNumber: merged.filter({ $0.status == 2 }).count ),
                        SortPagerParams(title: "聊天", badgeNumber: 100)
                    ]
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
                state.searchText = query
                if query.isEmpty {
                    state.filterList = state.friendList
                } else {
                    let filtered = state.friendList.filter { $0.name.contains(query) }
                    state.filterList = filtered
                }
                return .none
            case .refresh:
                state.filterList = nil
                state.friendList = []
                state.isRefreshing = true
                state.searchText = nil
                return .send(.viewDidLoad)
            case .invitationTapped:
                state.isStacked.toggle()
                return .none
            case .createSortButtons:
                state.sorts = [
                    SortPagerParams(title: "好友", badgeNumber: 0),
                    SortPagerParams(title: "聊天", badgeNumber: 0)
                ]
                return .none
            case .didATMButtonTapped:
                state.navigateToAddContact = true
                return .none
            case .closeContactButtonTapped:
                return .send(.popViewController)
            case .popViewController:
                state.navigateToAddContact = false
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
