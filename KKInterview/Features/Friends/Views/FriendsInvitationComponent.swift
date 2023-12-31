//
//  FriendsInvitationComponent.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit
import UIComponent
import KKLibrary
import KKApi

struct FriendsInvitationComponent: ComponentBuilder {
    
    var person: [Person] = []
    var isStacked: Bool = false
    var onTap: (Person) -> Void
    
    func build() -> Component {
        VStack(spacing: person.isEmpty ? 0 : isStacked ? -80 : 10) {
            ForEach(person.enumerated()) { index, people in
                let total = CGFloat(person.count)
                let position = CGFloat(index)
                let offset = total - position
                InvitationComponent(person: people)
                    .inset(h: isStacked ? (offset - 1) * 10 : 0)
                    .tappableView {
                        onTap(people)
                    }
            }
        }
        .inset(
            top: person.isEmpty ? 15 : 30,
            left: 30,
            bottom: person.isEmpty ? 15 : 30 + CGFloat(person.count) * (isStacked ? 10 : 0),
            right: 30
        )
        .view()
        .backgroundColor(.background1)
        .size(width: .fill)
    }
}

private struct InvitationComponent: ComponentBuilder {
    
    var person: Person
    
    func build() -> Component {
        HStack(alignItems: .center) {
            Image("img_friends_list")
            Space(width: 15)
            VStack(spacing: 2) {
                Text(person.name, font: .regular(size: 16))
                    .textColor(.primaryLabel)
                Text("邀請你成為好友：）", font: .regular(size: 13))
                    .textColor(.brownGray)
            }
            .flex()
            HStack(spacing: 15, alignItems: .center) {
                Image("btn_friends_agree")
                Image("btn_friends_delet")
            }
        }
        .inset(15)
        .view()
        .backgroundColor(.white)
        .cornerRadius(6)
        .shadow()
    }
}
