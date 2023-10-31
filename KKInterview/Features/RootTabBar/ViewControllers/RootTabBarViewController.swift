//
//  RootTabBarViewController.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import ComposableArchitecture
import Combine

final class RootTabBarViewController: UITabBarController {
    
    let store: StoreOf<RootTabBarStore>
    let viewStore: ViewStoreOf<RootTabBarStore>
    private var cancallable: [AnyCancellable] = []
    
    init() {
        self.store = Store(initialState: RootTabBarStore.State(), reducer: { RootTabBarStore() })
        self.viewStore = ViewStore(store, observe: { $0 })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingStyle()
        binding()
        
        viewStore.send(.viewDidLoad)
    }
    
    private func bindingStyle() {
        view.backgroundColor = .white
        tabBar.tintColor = .primaryTintColor
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: -0.5, width: view.bounds.width, height: 1)
        layer.backgroundColor = UIColor.separator.cgColor
        tabBar.layer.addSublayer(layer)
    }
    
    private func binding() {
        viewStore.publisher.viewControllers
            .map { $0.map(RootTabBarViewController.viewController) }
            .map { $0.map(UINavigationController.init(rootViewController:)) }
            .sink { [weak self] viewControllers in
                self?.setViewControllers(viewControllers, animated: false)
            }
            .store(in: &cancallable)
        viewStore.publisher.tabBarItemsData
            .removeDuplicates()
            .sink { [weak self] tabBarItemsData in
                self?.setTabBarItemStyles(tabBarItemsData)
            }
            .store(in: &cancallable)
        viewStore.publisher.selectedIndex
            .removeDuplicates()
            .sink { [weak self] selectedIndex in
                self?.selectedIndex = selectedIndex
            }
            .store(in: &cancallable)
    }
    
    private func setTabBarItemStyles(_ tabBarItemsData: TabBarItemsData) {
        for item in tabBarItemsData.items {
            switch item {
            case .wallets(let index):
                walletsTabBarItemStyle(tabBarItem(at: index))
            case .friends(let index):
                friendsTabBarItemStyle(tabBarItem(at: index))
            case .home(let index):
                homeTabBarItemStyle(tabBarItem(at: index))
            case .management(let index):
                managementTabBarItemStyle(tabBarItem(at: index))
            case .setting(let index):
                settingTabBarItemStyle(tabBarItem(at: index))
            }
        }
    }
    
    private func tabBarItem(at atIndex: Int) -> UITabBarItem? {
        if (tabBar.items?.count ?? 0) > atIndex {
            if let item = tabBar.items?[atIndex] {
                return item
            }
        }
        return nil
    }
    
    fileprivate static func viewController(from viewControllerData: RootViewControllerData) -> UIViewController {
        switch viewControllerData {
        case .wallets:
            return UIViewController()
        case .friends:
            return FriendsViewController()
        case .home:
            return UIViewController()
        case .management:
            return UIViewController()
        case .setting:
            return UIViewController()
        }
    }
}


// MARK: - Root TabBar Styles
private func walletsTabBarItemStyle(_ tabbarItem: UITabBarItem?) {
    guard let tabbarItem else { return }
    tabbarItem.title = "錢錢"
    tabbarItem.image = UIImage(named: "ic_tabbar_products")
}

private func friendsTabBarItemStyle(_ tabbarItem: UITabBarItem?) {
    guard let tabbarItem else { return }
    tabbarItem.title = "朋友"
    tabbarItem.image = UIImage(named: "ic_tabbar_friends")
}

private func homeTabBarItemStyle(_ tabbarItem: UITabBarItem?) {
    guard let tabbarItem else { return }
    tabbarItem.title = ""
    tabbarItem.image = UIImage(named: "ic_tabbar_home")?.withRenderingMode(.alwaysOriginal)
}

private func managementTabBarItemStyle(_ tabbarItem: UITabBarItem?) {
    guard let tabbarItem else { return }
    tabbarItem.title = "記帳"
    tabbarItem.image = UIImage(named: "ic_tabbar_manage")
}

private func settingTabBarItemStyle(_ tabbarItem: UITabBarItem?) {
    guard let tabbarItem else { return }
    tabbarItem.title = "設定"
    tabbarItem.image = UIImage(systemName: "slider.horizontal.3")
}
