//
//  KKTabBarView.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import UIKit
import UIComponent
import KKUILibrary

public protocol KKTabBarViewDelegate: AnyObject {
    func kkTabBarDidTap(tabBar: TabBarItem, at atIndex: Int)
}

public final class KKTabBarView: UIView {
    
    private let componentView = ComponentView()
    private let lineView = UIView()
    
    public weak var delegate: KKTabBarViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineView)
        addSubview(componentView)
        backgroundColor = .white
        lineView.backgroundColor = .primarySeparator
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        lineView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
        componentView.frame = bounds
    }
    
    public func populate(tabBarItemData: TabBarItemsData, selectedIndex: Int) {
        componentView.component = HStack(justifyContent: .spaceEvenly) {
            ForEach(tabBarItemData.items) { item in
                switch item {
                case let .wallets(index):
                    walletsTabBarItemStyle(isSelected: index == selectedIndex)
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .friends(index):
                    friendsTabBarItemStyle(isSelected: index == selectedIndex)
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .home(index):
                    homeTabBarItemStyle(isSelected: index == selectedIndex)
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .setting(index):
                    settingTabBarItemStyle(isSelected: index == selectedIndex)
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                case let .management(index):
                    managementTabBarItemStyle(isSelected: index == selectedIndex)
                        .tappableView { [weak self] in self?.delegate?.kkTabBarDidTap(tabBar: item, at: index) }
                }
            }
        }
        .size(width: .fill)
    }
    
    private func walletsTabBarItemStyle(isSelected: Bool) -> Component {
        VStack(alignItems: .center) {
            Image(UIImage(named: "ic_tabbar_products")!.withRenderingMode(.alwaysTemplate))
                .tintColor(isSelected ? .primaryTintColor : .brownGray)
            Text("錢錢", font: .medium(size: 11))
                .textColor(isSelected ? .primaryTintColor : .brownGray)
        }
        .inset(top: 5)
    }
    
    private func friendsTabBarItemStyle(isSelected: Bool) -> Component {
        VStack(alignItems: .center) {
            Image(UIImage(named: "ic_tabbar_friends")!.withRenderingMode(.alwaysTemplate))
                .tintColor(isSelected ? .primaryTintColor : .brownGray)
            Text("朋友", font: .medium(size: 11))
                .textColor(isSelected ? .primaryTintColor : .brownGray)
        }
        .inset(top: 5)
    }

    private func homeTabBarItemStyle(isSelected: Bool) -> Component {
        VStack(alignItems: .center) {
            Image("ic_tabbar_home")
                .offset(y: -13)
        }
    }

    private func managementTabBarItemStyle(isSelected: Bool) -> Component {
        VStack(alignItems: .center) {
            Image(UIImage(named: "ic_tabbar_manage")!.withRenderingMode(.alwaysTemplate))
                .tintColor(isSelected ? .primaryTintColor : .brownGray)
            Text("記帳", font: .medium(size: 11))
                .textColor(isSelected ? .primaryTintColor : .brownGray)
        }
        .inset(top: 5)
    }

    private func settingTabBarItemStyle(isSelected: Bool) -> Component {
        VStack(alignItems: .center) {
            Image(systemName: "slider.horizontal.3")
                .tintColor(isSelected ? .primaryTintColor : .brownGray)
                .size(width: 28, height: 28)
            Text("設定", font: .medium(size: 11))
                .textColor(isSelected ? .primaryTintColor : .brownGray)
        }
        .inset(top: 5)
    }

}
