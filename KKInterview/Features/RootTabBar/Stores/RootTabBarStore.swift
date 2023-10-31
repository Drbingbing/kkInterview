//
//  RootTabBarStore.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import Foundation
import ComposableArchitecture

struct RootTabBarStore: Reducer {
    
    struct State: Equatable {
        var viewControllers: [RootViewControllerData] = []
        var tabBarItemsData: TabBarItemsData = TabBarItemsData(items: [])
        var selectedIndex: Int = 0
    }
    
    enum Action {
        case viewDidLoad
        case tabBarItemsData(TabBarItemsData)
        case viewControllers([RootViewControllerData])
        case selectedIndex(Int)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewDidLoad:
                return .concatenate(
                    .send(.tabBarItemsData(tabData())),
                    .send(.viewControllers([.wallets, .friends, .home, .management, .setting])),
                    .send(.selectedIndex(1))
                )
            case let .tabBarItemsData(tabBarItemData):
                state.tabBarItemsData = tabBarItemData
                return .none
            case let .viewControllers(viewControllersData):
                state.viewControllers = viewControllersData
                return .none
            case let .selectedIndex(selectedIndex):
                state.selectedIndex = selectedIndex
                return .none
            }
        }
    }
}

private func tabData() -> TabBarItemsData {
    let items: [TabBarItem] = [
        .wallets(index: 0),
        .friends(index: 1),
        .home(index: 2),
        .management(index: 3),
        .setting(index: 4)
    ]
    return TabBarItemsData(items: items)
}