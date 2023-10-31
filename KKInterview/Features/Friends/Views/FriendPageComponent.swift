//
//  FriendPageComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent

struct FriendPageComponent: ComponentBuilder {
    
    
    func build() -> Component {
        HStack(spacing: 36) {
            Text("好友", font: .medium(size: 13))
                .textColor(.primaryLabel)
            Text("聊天", font: .medium(size: 13))
                .textColor(.primaryLabel)
        }
        .inset(UIEdgeInsets(top: 30, left: 32, bottom: 9, right: 32))
        .view()
        .backgroundColor(.background1)
        .size(width: .fill)
    }
}
