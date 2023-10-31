//
//  FriendsInvitationComponent.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit
import UIComponent

struct FriendsInvitationComponent: ComponentBuilder {
    
    func build() -> Component {
        VStack {
            InvitationComponent()
        }
        .inset(top: 30, left: 30, bottom: 30, right: 30)
        .view()
        .backgroundColor(.background1)
        
    }
}

private struct InvitationComponent: ComponentBuilder {
    
    func build() -> Component {
        HStack(alignItems: .center) {
            Image("img_friends_list")
            Space(width: 15)
            VStack(spacing: 2) {
                Text("彭安亭", font: .regular(size: 16))
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
