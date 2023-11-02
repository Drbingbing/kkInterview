//
//  SortPagerParams.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import Foundation

struct SortPagerParams: Equatable {
    
    var title: String
    var badgeNumber: Int
    
    init(title: String, badgeNumber: Int) {
        self.title = title
        self.badgeNumber = badgeNumber
    }
}
