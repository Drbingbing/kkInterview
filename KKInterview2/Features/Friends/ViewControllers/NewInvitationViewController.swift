//
//  NewInvitationViewController.swift
//  KKInterview2
//
//  Created by Bing Bing on 2023/11/3.
//

import UIKit
import UIComponent
import KKApi
import KKLibrary
import KKUILibrary
import ComposableArchitecture
import Combine

protocol NewInvitationViewControllerDelegate: AnyObject {
    func didCardTapped(person: Person)
}

final class NewInvitationViewController: UIViewController {
    
    let store = Store(initialState: NewInvitationStore.State(), reducer: { NewInvitationStore() })
    private lazy var viewStore = ViewStore(store, observe: { $0 })
    
    weak var delegate: NewInvitationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        bindingStyle()
        bindingUI()
    }
    
    private func binding() {
        viewStore.publisher.invitations
            .sink { [weak self] _ in
                self?.componentView.component = self?.component
            }
            .store(in: &cancellables)
        viewStore.publisher
            .isStacked
            .sink { [weak self] _ in
                self?.componentView.component = self?.component
            }
            .store(in: &cancellables)
    }
    
    private func bindingStyle() {
        view.backgroundColor = .background1
        view.clipsToBounds = false
    }
    
    private func bindingUI() {
        view.addSubview(componentView)
        
        componentView.backgroundColor = .clear
        componentView.component = component
        componentView.animator = AnimatedReloadAnimator()
        componentView.clipsToBounds = false
        componentView.delaysContentTouches = false
        componentView.translatesAutoresizingMaskIntoConstraints = false
        
        componentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        componentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        componentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        componentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private var component: Component? {
        if viewStore.invitations.isEmpty { return nil }
        return VStack(spacing: viewStore.isStacked ? -20 : 10) {
            ForEach(viewStore.invitations.enumerated()) { index, person in
                let total = CGFloat(viewStore.invitations.count)
                let position = CGFloat(index)
                let offset = total - position
                InvitationComponent(person: person)
                    .tappableView { [weak self] in
                        self?.delegate?.didCardTapped(person: person)
                    }
                    .inset(bottom: viewStore.isStacked ? -offset * 20 : 0)
                    .inset(h: viewStore.isStacked ? CGFloat(offset) * 10 : 0)
            }
        }
        .inset(
            top: 30,
            left: 30,
            bottom: 0,
            right: 30
        )
        .view()
        .backgroundColor(.background1)
        .animator(AnimatedReloadAnimator())
    }
    
    private let componentView = ComponentScrollView()
    private var cancellables: [AnyCancellable] = []
}

private struct InvitationComponent: ComponentBuilder {
    
    var person: Person
    
    func build() -> Component {
        HStack(alignItems: .center) {
            Image("img_friends_list")
            Space(width: 15)
            VStack(spacing: 2) {
                Text(person.name, font: .regular(size: 16))
                    .textColor(.primaryLabel)
                Text("邀請你成為好友：）", font: .regular(size: 13))
                    .textColor(.brownGray)
            }
            .flex()
            HStack(spacing: 15, alignItems: .center) {
                Image("btn_friends_agree")
                Image("btn_friends_delet")
            }
        }
        .inset(15)
        .view()
        .backgroundColor(.white)
        .cornerRadius(6)
        .update {
            $0.shadowColor = .black.withAlphaComponent(0.1)
            $0.shadowOffset = CGSize(width: 0, height: 4)
            $0.shadowRadius = 8
            $0.shadowOpacity = 1
        }
    }
}


extension NewInvitationViewController {
    
    public func populate(person: [Person], isStacked: Bool = true) {
        store.send(.configure(person, stacked: isStacked))
    }
}
