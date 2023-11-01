//
//  FriendsViewController.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import FloatingPanel
import ComposableArchitecture
import UIComponent
import Combine
import KKLibrary

final class FriendsViewController: UIViewController {
    
    let store: StoreOf<FriendsStore>
    let viewStore: ViewStoreOf<FriendsStore>
    
    init(episode: InterviewEpisode) {
        self.store = Store(initialState: FriendsStore.State(), reducer: { FriendsStore(episode: episode) })
        self.viewStore = ViewStore(store, observe: { $0 })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        bindingStyle()
        setupScrollView()
        setupNavigationHeaderCotroller()
        setupNotificationObservers()
        
        viewStore.send(.viewDidLoad)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        componentView.frame = view.bounds.inset(by: UIEdgeInsets(top: view.safeAreaInsets.top + 44, left: 0, bottom: view.safeAreaInsets.bottom + 54, right: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func bindingStyle() {
        view.backgroundColor = .background1
    }
    
    private func binding() {
        viewStore.publisher.currentUser
            .sink { [weak self] _ in
                guard let self else { return }
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
        viewStore.publisher.friendList
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self else { return }
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
        viewStore.publisher.showKeyboard
            .removeDuplicates()
            .sink { [weak self] showKeyboard in
                guard let self else { return }
                if showKeyboard {
                    self.componentView.addGestureRecognizer(self.dismissKeyboardGesture)
                } else {
                    self.componentView.removeGestureRecognizer(self.dismissKeyboardGesture)
                    self.view.endEditing(true)
                }
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
        viewStore.publisher.filterList
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self else { return }
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
        viewStore.publisher.isRefreshing
            .removeDuplicates()
            .sink { [weak self] isRefreshing in
                isRefreshing ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
            }
            .store(in: &cancellable)
        viewStore.publisher.isCollapse
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self else { return }
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
    }
    
    private func setupScrollView() {
        view.addSubview(componentView)
        componentView.component = component
        componentView.animator = AnimatedReloadAnimator(cascade: true)
        componentView.delaysContentTouches = false
        componentView.delegate = self
        componentView.refreshControl = refreshControl
    }
    
    private func setupNavigationHeaderCotroller() {
        
        let content = FloatingContentViewController()
        let fpc = FloatingPanelController()
        fpc.layout = NavigationHeaderPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.panGestureRecognizer.isEnabled = false
        fpc.surfaceView.appearance.shadows = []
        fpc.surfaceView.grabberHandle.alpha = 0
        fpc.set(contentViewController: content)
        
        content.component = HStack(spacing: 24) {
            Image("ic_nav_pink_withdraw")
                .tappableView {}
            Image("ic_nav_pink_transfer")
                .tappableView {}
            Space().flex()
            Image("ic_navpink_scan")
                .tappableView {}
        }
        .inset(h: 20)
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(forName: .kk_userUpdated, object: nil, queue: nil) { [weak self] _ in
            self?.store.send(.currentUserUpdated)
        }
    }
    
    @objc private func dismissKeyboard(ges: UITapGestureRecognizer) {
        store.send(.searchBarEndEditing)
    }
    
    @objc private func refresh() {
        store.send(.refresh)
    }
    
    // MARK: - Private properties
    private lazy var dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    private lazy var refreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view.tintColor = .primaryTintColor
        view.transform = .identity.scaledBy(0.6)
        return view
    }()
    private var cancellable: [AnyCancellable] = []
    private let componentView = ComponentScrollView()
    private let searchBar = SearchBarView()
    private var component: Component {
        VStack {
            if !viewStore.showKeyboard {
                PersonalInfoComponent(user: viewStore.currentUser)
                FriendsInvitationComponent(persons: viewStore.invitations, isExpand: viewStore.isCollapse) { [weak self] person in
                    self?.viewStore.send(.invitationTapped(person))
                }
                FriendPageComponent()
                FriendsPageIndicatorComponent()
            }
            Separator(color: .primarySeparator)
            HStack(spacing: 15, alignItems: .center) {
                searchBar
                    .then {
                        $0.searchBar.delegate = self
                        $0.searchBar.searchBarStyle = .minimal
                        $0.searchBar.placeholder = "想轉一筆給誰呢？"
                        $0.searchBar.searchTextField.font = .regular()
                    }
                    .flex()
                Image("ic_btn_add_friends")
                    .tappableView {}
            }
            .inset(UIEdgeInsets(top: 15, left: 30, bottom: 10, right: 30))
            .view()
            .backgroundColor(.white)
            FriendListComponent(person: viewStore.filterList ?? viewStore.friendList)
        }
    }
}

// MARK: - UISearchBarDelegate
extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        store.send(.searchTextChanged(searchText))
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        store.send(.searchBarBeginEditing)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        store.send(.searchBarEndEditing)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            store.send(.searchTextChanged(searchText))
        }
        store.send(.searchBarEndEditing)
    }
}

// MARK: - UIScrollViewDelegate
extension FriendsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.isDecelerating {
            store.send(.searchBarEndEditing)
        }
    }
}
