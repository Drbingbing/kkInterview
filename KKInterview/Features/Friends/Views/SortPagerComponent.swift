//
//  SortPagerComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent
import BaseToolbox
import KKLibrary

struct SortPagerComponent: ComponentBuilder {
    
    var sorts: [SortPagerParams]
    
    func build() -> Component {
        HStack(spacing: 36) {
            ForEach(sorts) { sort in
                Text(sort.title, font: .medium(size: 13))
                    .textColor(.primaryLabel)
                    .tappableView {}
                    .if(sort.badgeNumber > 0) { text in
                        text
                            .badge(
                                verticalAlignment: .before,
                                horizontalAlignment: .after,
                                offset: CGPoint(x: 0, y: 9)
                            ) {
                                FriendPageBadge(sort.badgeNumber)
                            }
                    }
            }
        }
        .inset(left: 32, bottom: 9, right: 32)
        .view()
        .backgroundColor(.background1)
        .size(width: .fill)
    }
}

private struct FriendPageBadge: ComponentBuilder {
    
    private static var font = UIFont.medium(size: 12)
    
    var number: String
    var size: CGSize
    
    init(_ number: Int) {
        let numberString = number > 99 ? "99+" : "\(number)"
        let size = numberString.size(forFont: Self.font, maxWidth: 100)
        
        self.number = numberString
        if size.width < size.height {
            self.size = CGSize(width: size.height, height: size.height)
        } else {
            self.size = size
        }
    }
    
    func build() -> Component {
        Text(number, font: Self.font)
            .textColor(.white)
            .textAlignment(.center)
            .inset(top: 3.5, left: 3.5, bottom: 4.5, right: 4.5)
            .size(size.inset(by: -UIEdgeInsets(top: 3.5, left: 3.5, bottom: 4.5, right: 4.5)))
            .view()
            .backgroundColor(.softPink)
            .update {
                $0.cornerRadius = $0.frame.height / 2
            }
    }
}
