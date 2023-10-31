//
//  SearchBarComponent.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit
import UIComponent

struct SearchBarComponent: ComponentBuilder {
    
    func build() -> Component {
        HStack(spacing: 15, alignItems: .center) {
            SearchBarView()
                .then {
                    $0.searchBar.searchBarStyle = .minimal
                    $0.searchBar.placeholder = "想轉一筆給誰呢？"
                    $0.searchBar.searchTextField.font = .regular()
                }
                .flex()
            Image("ic_btn_add_friends")
        }
        .inset(UIEdgeInsets(top: 15, left: 30, bottom: 10, right: 30))
    }
}
