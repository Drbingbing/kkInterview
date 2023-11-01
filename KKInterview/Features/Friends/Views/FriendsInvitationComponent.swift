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
    var isExpand: Bool = false
    var onTap: (Person) -> Void
    
    func build() -> Component {
        if isExpand {
            VStack(spacing: 10) {
                ForEach(persons.reversed().enumerated()) { index, person in
                    InvitationComponent(person: person)
                        .tappableView {
                            onTap(person)
                        }
                }
            }
            .inset(top: persons.isEmpty ? 15 : 30, left: 30, bottom: persons.isEmpty ? 15 : 30, right: 30)
            .view()
            .backgroundColor(.background1)
        } else {
            ZStack {
                ForEach(persons.reversed().enumerated()) { index, person in
                    InvitationComponent(person: person)
                        .tappableView {
                            onTap(person)
                        }
                        .offset(y: isExpand ? CGFloat(index) * -70 : CGFloat(index) * -12)
                        .inset(h: isExpand ? 0 : CGFloat(persons.count - index) * 10)
                }
            }
            .inset(top: persons.isEmpty ? 15 : 18 + CGFloat(persons.count) * 12, left: 30, bottom: persons.isEmpty ? 15 : 30, right: 30)
            .view()
            .backgroundColor(.background1)
        }
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
                    .textColor(.secondaryLabel)
            }
            .flex()
            HStack(spacing: 15, alignItems: .center) {
                Image("btn_friends_agree")
                Image("btn_friends_delet")
            }
        }
        .inset(15)
        .shadow()
        .cornerRadius(6)
    }
}
