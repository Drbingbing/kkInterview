//
//  FriendsInvitationComponent.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit
import UIComponent
import KKLibrary

struct FriendsInvitationComponent: ComponentBuilder {
    
    var persons: [Person] = []
    var isStacked: Bool = false
    var onTap: (Person) -> Void
    
    func build() -> Component {
        VStack(spacing: 10) {
            ForEach(persons.enumerated()) { index, person in
                let yOffset: CGFloat = (isStacked ? 60 : 0) * CGFloat(-index)
                InvitationComponent(person: person)
                    .tappableView {
                        onTap(person)
                    }
                    .zPosition(isStacked ? CGFloat(persons.count - index) : 1)
                    .offset(y: yOffset)
                    .inset(h: isStacked ? CGFloat(index) * 10 : 0)
            }
        }
        .inset(
            top: persons.isEmpty ? 15 : 30,
            left: 30,
            bottom: persons.isEmpty ? 15 : 30 - (isStacked ? CGFloat(persons.count - 1) * 60 : 0),
            right: 30
        )
        .view()
        .backgroundColor(.background1)
        .animator(AnimatedReloadAnimator())
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
