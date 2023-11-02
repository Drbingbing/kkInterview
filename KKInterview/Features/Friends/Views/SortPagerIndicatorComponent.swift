//
//  SortPagerIndicatorComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent
import KKUILibrary

struct SortPagerIndicatorComponent: ComponentBuilder {
    
    
    func build() -> Component {
        VStack {
            Color(.primaryTintColor, radius: 2)
                .size(width: 20, height: 4)
        }
        .inset(h: 35)
        .view()
        .backgroundColor(.background1)
        .size(width: .fill)
    }
}
