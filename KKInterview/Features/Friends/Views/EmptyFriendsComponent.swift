//
//  EmptyFriendsComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent
import BaseToolbox

struct EmptyFriendsComponent: ComponentBuilder {
    
    func build() -> Component {
        VStack(justifyContent: .center, alignItems: .center) {
            Space(height: 30)
            Image("img_friends_empty")
            Space(height: 40)
            Text("就從加好友開始吧：）", font: .medium(size: 21))
                .textColor(.primaryLabel)
            Space(height: 8)
            Text("與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）", font: .regular())
                .textColor(.secondaryLabel)
            Space(height: 25)
            LinearGradient(colors: [.frogGreen, .boogerGreen])
                .size(width: 192, height: 40)
                .badge(verticalAlignment: .center, horizontalAlignment: .center) {
                    Text("加好友", font: .medium(size: 16))
                        .textColor(.white)
                }
                .badge(verticalAlignment: .center, horizontalAlignment: .end) {
                    Image("ic_add_friend_white")
                        .inset(right: 8)
                }
            Space(height: 37)
            HStack(alignItems: .center) {
                Text("幫助好友更快找到你？", font: .regular(size: 13))
                    .textColor(.secondaryLabel)
                Text(
                    attributedString: NSAttributedString(
                        string: "設定 KOKO ID",
                        attributes: [
                            .underlineColor: UIColor.primaryTintColor,
                            .underlineStyle: NSUnderlineStyle.thick.rawValue,
                            .font: UIFont.regular(size: 13),
                            .foregroundColor: UIColor.primaryTintColor
                        ]
                    )
                )
            }
        }
        .size(width: .fill)
    }
}
