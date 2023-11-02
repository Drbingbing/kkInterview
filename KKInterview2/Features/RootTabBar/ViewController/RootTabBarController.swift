//
//  RootTabBarController.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import ComposableArchitecture
import KKLibrary
import Combine

final class RootTabBarController: UITabBarController {
    
    let store: StoreOf<RootTabBarStore>
    let viewStore: ViewStoreOf<RootTabBarStore>
    
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
        
        setupCustomTabBar()
        bindingStyle()
        binding()
        
        store.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func updateViewConstraints() {
        kkTabBar.translatesAutoresizingMaskIntoConstraints = false
        kkTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        kkTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        kkTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        kkTabBar.heightAnchor.constraint(equalToConstant: view.safeAreaInsets.bottom + 54).isActive = true
        super.updateViewConstraints()
    }
    
    private func bindingStyle() {
        view.backgroundColor = .white
        kkTabBar.backgroundColor = .white
        tabBar.isHidden = true
    }
    
    private func binding() {
        viewStore.publisher.viewControllers
            .map { $0.map(RootTabBarController.viewController) }
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
    
    private func setupCustomTabBar() {
        view.addSubview(kkTabBar)
        view.setNeedsUpdateConstraints()
    }
    
    private func setTabBarItemStyles() {
        kkTabBar.populate(tabBarItemsData: viewStore.tabBarItemsData)
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
    
    
    // MARK: - Private properties
    private let kkTabBar = KKTabBarView()
    private var cancellable: [AnyCancellable] = []
}
