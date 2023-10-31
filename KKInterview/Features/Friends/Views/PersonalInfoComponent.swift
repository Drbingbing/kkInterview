//
//  PersonalInfoComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent

struct PersonalInfoComponent: ComponentBuilder {
    
    
    func build() -> Component {
        HStack {
            VStack(spacing: 8) {
                Text("紫琳", font: .medium(size: 17))
                    .textColor(.primaryLabel)
                HStack(alignItems: .center) {
                    Text("設定KOKO ID", font: .regular(size: 13))
                        .textColor(.primaryLabel)
                    Image("arrow_right_deep_gray")
                    Space(width: 15)
                    Color(.primaryTintColor, radius: 5)
                        .size(width: 10, height: 10)
                }
            }
            .flex()
            Image("img_friends_female_default")
        }
        .inset(h: 30)
        .view()
        .backgroundColor(.background1)
    }
}
