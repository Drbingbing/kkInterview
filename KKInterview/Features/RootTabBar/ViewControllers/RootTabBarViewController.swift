//
//  RootTabBarViewController.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import ComposableArchitecture
import Combine
import KKUILibrary
import KKLibrary
import KKApi

final class RootTabBarViewController: UITabBarController {
    
    let store: StoreOf<RootTabBarStore>
    let viewStore: ViewStoreOf<RootTabBarStore>
    private var cancellable: [AnyCancellable] = []
    private let kkTabBar = KKTabBarView()
    
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
        setupCustomTabBar()
        
        viewStore.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func updateViewConstraints() {
        kkTabBar.translatesAutoresizingMaskIntoConstraints = false
        kkTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        kkTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        kkTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        kkTabBar.heightAnchor.constraint(equalToConstant: view.safeAreaInsets.bottom + 54).isActive = true
        super.updateViewConstraints()
    }
    
    private func setupCustomTabBar() {
        view.addSubview(kkTabBar)
        kkTabBar.delegate = self
        view.setNeedsUpdateConstraints()
    }
    
    private func bindingStyle() {
        view.backgroundColor = .white
        tabBar.isHidden = true
    }
    
    private func binding() {
        viewStore.publisher.viewControllers
            .map { $0.map(RootTabBarViewController.viewController) }
            .map { $0.map(UINavigationController.init(rootViewController:)) }
            .sink { [weak self] viewControllers in
                self?.setViewControllers(viewControllers, animated: false)
            }
            .store(in: &cancellable)
        viewStore.publisher.tabBarItemsData
            .removeDuplicates()
            .sink { [weak self] tabBarItemsData in
                self?.setTabBarItemStyles()
            }
            .store(in: &cancellable)
        viewStore.publisher.selectedIndex
            .removeDuplicates()
            .sink { [weak self] selectedIndex in
                self?.selectedIndex = selectedIndex
                self?.setTabBarItemStyles()
            }
            .store(in: &cancellable)
        viewStore.publisher.currentUser
            .sink { user in
                guard let user else { return }
                AppEnvironment.updateCurrentUser(user)
                NotificationCenter.default.post(.init(name: .kk_userUpdated))
            }
            .store(in: &cancellable)
    }
    
    private func setTabBarItemStyles() {
        kkTabBar.populate(tabBarItemData: viewStore.tabBarItemsData, selectedIndex: viewStore.selectedIndex)
    }
    
    fileprivate static func viewController(from viewControllerData: RootViewControllerData) -> UIViewController {
        switch viewControllerData {
        case .wallets:
            return UIViewController()
        case .friends:
            return FriendsViewController(episode: AppEnvironment.current.episode)
        case .home:
            return UIViewController()
        case .management:
            return UIViewController()
        case .setting:
            return UIViewController()
        }
    }
}


// MARK: - KKTabBarViewDelegate
extension RootTabBarViewController: KKTabBarViewDelegate {
    
    func kkTabBarDidTap(tabBar: TabBarItem, at atIndex: Int) {
        viewStore.send(.selectedIndex(atIndex))
    }
}
