//
//  SortPagerParams.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import Foundation

public struct SortPagerParams: Equatable {
    
    public var title: String
    public var badgeNumber: Int
    
    public init(title: String, badgeNumber: Int) {
        self.title = title
        self.badgeNumber = badgeNumber
    }
}
