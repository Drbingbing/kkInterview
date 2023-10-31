//
//  FriendListComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent

struct FriendListComponent: ComponentBuilder {
    
    func build() -> Component {
        VStack {
            ForEach(0..<5) { _ in
                FriendComponent()
                Separator(color: .secondarySeparator)
                    .inset(left: 85, right: 30)
            }
        }
        .inset(h: 20)
    }
}

private struct FriendComponent: ComponentBuilder {
    
    func build() -> Component {
        HStack(alignItems: .center) {
            Image("ic_friends_star")
            Space(width: 6)
            Image("img_friends_list")
            Space(width: 15)
            Text("黃靖僑", font: .regular(size: 16))
                .textColor(.primaryLabel)
                .flex()
            HStack(spacing: 25, alignItems: .center) {
                Text("轉帳中", font: .medium(size: 14))
                    .textColor(.primaryTintColor)
                    .inset(h: 10, v: 2)
                    .view()
                    .borderColor(.primaryTintColor)
                    .borderWidth(1)
                    .cornerRadius(2)
                Image("ic_friends_more")
                Space(width: 10)
            }
        }
        .inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
    }
}
