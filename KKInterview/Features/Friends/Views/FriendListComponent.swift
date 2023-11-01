//
//  FriendListComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent
import KKLibrary

struct FriendListComponent: ComponentBuilder {
    
    var person: [Person]
    
    func build() -> Component {
        if person.isEmpty {
            EmptyFriendsComponent()
        } else {
            VStack {
                ForEach(person) { person in
                    FriendComponent(person: person)
                    Separator(color: .secondarySeparator)
                        .inset(left: 85, right: 30)
                }
            }
            .inset(h: 20)
            .view()
            .backgroundColor(.white)
        }
    }
}

private struct FriendComponent: ComponentBuilder {
    
    var person: Person
    
    func build() -> Component {
        HStack(alignItems: .center) {
            Image("ic_friends_star")
                .alpha(person.isTop ? 1 : 0)
                .tappableView {}
            Space(width: 6)
            Image("img_friends_list")
            Space(width: 15)
            Text(person.name, font: .regular(size: 16))
                .textColor(.primaryLabel)
                .flex()
            HStack(spacing: person.status == 2 ? 10 : 25, alignItems: .center) {
                Text("轉帳", font: .medium(size: 14))
                    .textColor(.primaryTintColor)
                    .inset(h: 10, v: 2)
                    .view()
                    .borderColor(.primaryTintColor)
                    .borderWidth(1.2)
                    .cornerRadius(2)
                    .tappableView {}
                if person.status == 2 {
                    Text("邀請中", font: .medium(size: 14))
                        .textColor(.brownGray)
                        .inset(h: 10, v: 2)
                        .view()
                        .borderColor(.pinkishGray)
                        .borderWidth(1.2)
                        .cornerRadius(2)
                        .tappableView {}
                } else {
                    Image("ic_friends_more")
                        .tappableView {}
                }
                Space(width: 10)
            }
        }
        .inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
    }
}
