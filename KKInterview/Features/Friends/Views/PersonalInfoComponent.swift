//
//  PersonalInfoComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent
import KKLibrary
import KKUILibrary
import KKApi

struct PersonalInfoComponent: ComponentBuilder {
    
    var user: User?
    
    func build() -> Component {
        HStack {
            VStack(spacing: 8) {
                Text(user?.name ?? "", font: .medium(size: 17))
                    .textColor(.primaryLabel)
                HStack(alignItems: .center) {
                    if let user {
                        Text("KOKO ID：\(user.kokoID)", font: .regular(size: 13))
                            .textColor(.primaryLabel)
                    } else {
                        Text("設定KOKO ID", font: .regular(size: 13))
                            .textColor(.primaryLabel)
                    }
                    
                    Image("arrow_right_deep_gray")
                    if user == nil {
                        Space(width: 15)
                        Color(.primaryTintColor, radius: 5)
                            .size(width: 10, height: 10)
                    }
                }
                .tappableView {}
            }
            .flex()
            Image("img_friends_female_default")
                .tappableView {}
        }
        .inset(h: 30)
        .view()
        .backgroundColor(.background1)
    }
}
