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
import KKUILibrary
import KKApi

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
        setupNavigationHeaderController()
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
        view.backgroundColor = .white
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
            .sink { [weak self] friends in
                guard let self else { return }
                self.friendListView.populate(person: friends)
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
            .compactMap { $0 }
            .sink { [weak self] filtered in
                guard let self else { return }
                self.friendListView.populate(person: filtered)
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
        viewStore.publisher.isRefreshing
            .removeDuplicates()
            .sink { [weak self] isRefreshing in
                isRefreshing ? self?.friendListView.refreshControl.beginRefreshing() : self?.friendListView.refreshControl.endRefreshing()
            }
            .store(in: &cancellable)
        viewStore.publisher.isStacked
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self else { return }
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
        viewStore.publisher.sorts
            .removeDuplicates()
            .sink { [weak self] sorts in
                guard let self else { return }
                self.sortPagerView.populate(sorts: sorts)
                self.componentView.component = self.component
            }
            .store(in: &cancellable)
        viewStore.publisher
            .searchText
            .sink { [weak self] text in
                self?.searchBar.searchBar.text = text
            }
            .store(in: &cancellable)
        viewStore.publisher
            .navigateToAddContact
            .removeDuplicates()
            .sink { [weak self] navigate in
                guard let self else { return }
                if navigate {
                    let vc = AddContactViewController()
                    vc.delegate = self
                    self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.tabBarController?.navigationController?.popViewController(animated: true)
                }
            }
            .store(in: &cancellable)
    }
    
    private func setupScrollView() {
        view.addSubview(componentView)
        componentView.component = component
        componentView.animator = AnimatedReloadAnimator(cascade: true)
    }
    
    private func setupNavigationHeaderController() {
        
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
                .tappableView { [weak self] in
                    self?.store.send(.didATMButtonTapped)
                }
            Image("ic_nav_pink_transfer")
                .tappableView { }
            Space().flex()
            Image("ic_navpink_scan")
                .tappableView { }
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
    
    // MARK: - Private properties
    private lazy var dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    private var cancellable: [AnyCancellable] = []
    private let componentView = ComponentView()
    private let sortPagerView = SortPagerView()
    private lazy var friendListView = {
        let view = FriendListView()
        view.delegate = self
        return view
    }()
        
    private lazy var searchBar = {
        let view = SearchBarView()
        view.searchBar.delegate = self
        return view
    }()
    
    private var component: Component {
        VStack {
            if !viewStore.showKeyboard {
                PersonalInfoComponent(user: viewStore.currentUser)
                FriendsInvitationComponent(person: viewStore.invitations, isStacked: viewStore.isStacked) { [weak self] person in
                    self?.viewStore.send(.invitationTapped(person))
                }
                sortPagerView
                    .size(width: .fill, height: 30)
            }
            Separator(color: .primarySeparator)
            searchBar
                .size(width: .fill, height: 61)
            friendListView
                .size(width: .fill, height: .absolute(view.bounds.height))
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

// MARK: - AddContactViewControllerDelegate
extension FriendsViewController: AddContactViewControllerDelegate {
    
    func didBackButtonTapped(_ viewController: AddContactViewController) {
        store.send(.closeContactButtonTapped)
    }
    
    func didCloseButtonTapped(_ viewController: AddContactViewController) {
        store.send(.closeContactButtonTapped)
    }
}

// MARK: - FriendListViewDelegate
extension FriendsViewController: FriendListViewDelegate {
    
    func friendListDidRefresh() {
        store.send(.refresh)
    }
}
