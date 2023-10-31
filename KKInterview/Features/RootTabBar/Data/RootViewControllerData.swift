//
//  RootViewControllerData.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import Foundation

typealias RootViewControllerIndex = Int

enum RootViewControllerData: Equatable {
    case wallets
    case friends
    case home
    case management
    case setting
}

enum TabBarItem: Equatable {
    case wallets(index: RootViewControllerIndex)
    case friends(index: RootViewControllerIndex)
    case home(index: RootViewControllerIndex)
    case management(index: RootViewControllerIndex)
    case setting(index: RootViewControllerIndex)
}

struct TabBarItemsData: Equatable {
    let items: [TabBarItem]
}
