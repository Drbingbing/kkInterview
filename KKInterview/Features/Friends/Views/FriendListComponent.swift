//
//  FriendListComponent.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent
import KKLibrary
import KKUILibrary
import KKApi
import ComposableArchitecture
import Combine

protocol FriendListViewDelegate: AnyObject {
    func friendListDidRefresh()
}

final class FriendListView: View {
    
    weak var delegate: FriendListViewDelegate?
    
    lazy var refreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view.tintColor = .primaryTintColor
        view.transform = .identity.scaledBy(0.6)
        return view
    }()
    
    private let store = Store(initialState: FriendListStore.State(), reducer: { FriendListStore() })
    private lazy var viewStore = ViewStore(store, observe: { $0 })
    private let componentView = ComponentScrollView()
    private var cancellables: [AnyCancellable] = []
    
    
    override func viewDidLoad() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        componentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        componentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        componentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        componentView.refreshControl = refreshControl
        componentView.animator = AnimatedReloadAnimator()
        
        viewStore.publisher.list
            .sink { [weak self] person in
                guard let self else { return }
                if person.isEmpty {
                    self.componentView.component = VStack {
                        EmptyFriendsComponent()
                    }
                    return
                }
                self.componentView.component = VStack {
                    ForEach(person) { person in
                        FriendComponent(person: person)
                        Separator(color: .secondarySeparator)
                            .inset(left: 85, right: 30)
                    }
                }
                .inset(h: 20)
                .view()
                .backgroundColor(.white)
            }
            .store(in: &cancellables)
    }
    
    @objc private func refresh() {
        delegate?.friendListDidRefresh()
    }
    
    func populate(person: [Person]) {
        store.send(.configure(person))
    }
}

private struct FriendComponent: ComponentBuilder {
    
    var person: Person
    
    func build() -> Component {
        HStack(alignItems: .center) {
            Image("ic_friends_star")
                .alpha(person.isTop ? 1 : 0)
                .tappableView {}
            Space(width: 6)
            Image("img_friends_list")
            Space(width: 15)
            Text(person.name, font: .regular(size: 16))
                .textColor(.primaryLabel)
                .flex()
            HStack(spacing: person.status == 2 ? 10 : 25, alignItems: .center) {
                Text("轉帳", font: .medium(size: 14))
                    .textColor(.primaryTintColor)
                    .inset(h: 10, v: 2)
                    .view()
                    .borderColor(.primaryTintColor)
                    .borderWidth(1.2)
                    .cornerRadius(2)
                    .tappableView {}
                if person.status == 2 {
                    Text("邀請中", font: .medium(size: 14))
                        .textColor(.brownGray)
                        .inset(h: 10, v: 2)
                        .view()
                        .borderColor(.pinkishGray)
                        .borderWidth(1.2)
                        .cornerRadius(2)
                        .tappableView {}
                } else {
                    Image("ic_friends_more")
                        .tappableView {}
                }
                Space(width: 10)
            }
        }
        .inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
    }
}
