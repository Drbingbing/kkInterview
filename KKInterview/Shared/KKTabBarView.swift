//
//  KKTabBarView.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import UIKit
import UIComponent

protocol KKTabBarViewDelegate: AnyObject {
    func kkTabBarDidTap(tabBar: TabBarItem, at atIndex: Int)
}

final class KKTabBarView: UIView {
    
    private let componentView = ComponentView()
    private let lineView = UIView()
    
    weak var delegate: KKTabBarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineView)
        addSubview(componentView)
        backgroundColor = .white
        lineView.backgroundColor = .primarySeparator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
        componentView.frame = bounds
    }
    
    func populate(tabBarItemData: TabBarItemsData) {
        componentView.component = HStack(justifyContent: .spaceEvenly) {
            ForEach(tabBarItemData.items) { item in
                switch item {
                case let .wallets(index):
                    walletsTabBarItemStyle()
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .friends(index):
                    friendsTabBarItemStyle()
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .home(index):
                    homeTabBarItemStyle()
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .setting(index):
                    settingTabBarItemStyle()
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .management(index):
                    managementTabBarItemStyle()
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                }
            }
        }
        .size(width: .fill)
    }
    
    private func walletsTabBarItemStyle() -> Component {
        VStack(alignItems: .center) {
            Image("ic_tabbar_products")
            Text("錢錢", font: .medium(size: 11))
                .textColor(.brownGray)
        }
        .inset(top: 5)
    }
    
    private func friendsTabBarItemStyle() -> Component {
        VStack(alignItems: .center) {
            Image("ic_tabbar_friends")
            Text("朋友", font: .medium(size: 11))
                .textColor(.primaryTintColor)
        }
        .inset(top: 5)
    }

    private func homeTabBarItemStyle() -> Component {
        VStack(alignItems: .center) {
            Image("ic_tabbar_home")
                .offset(y: -13)
        }
    }

    private func managementTabBarItemStyle() -> Component {
        VStack(alignItems: .center) {
            Image("ic_tabbar_manage")
            Text("記帳", font: .medium(size: 11))
                .textColor(.brownGray)
        }
        .inset(top: 5)
    }

    private func settingTabBarItemStyle() -> Component {
        VStack(alignItems: .center) {
            Image(systemName: "slider.horizontal.3")
                .tintColor(.brownGray)
                .size(width: 28, height: 28)
            Text("設定", font: .medium(size: 11))
                .textColor(.brownGray)
        }
        .inset(top: 5)
    }

}
