//
//  RootViewControllerData.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import Foundation

public typealias RootViewControllerIndex = Int

public enum RootViewControllerData: Equatable {
    case wallets
    case friends
    case home
    case management
    case setting
}

public enum TabBarItem: Equatable {
    case wallets(index: RootViewControllerIndex)
    case friends(index: RootViewControllerIndex)
    case home(index: RootViewControllerIndex)
    case management(index: RootViewControllerIndex)
    case setting(index: RootViewControllerIndex)
}

public struct TabBarItemsData: Equatable {
    public let items: [TabBarItem]
    
    public init(items: [TabBarItem]) {
        self.items = items
    }
}
