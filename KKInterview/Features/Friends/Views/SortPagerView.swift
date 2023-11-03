//
//  SortPagerView.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent
import BaseToolbox
import KKLibrary
import KKUILibrary
import ComposableArchitecture
import Combine

final class SortPagerView: View {
    
    private var cancellables: [AnyCancellable] = []
    private let store = Store(initialState: SortPagerStore.State(), reducer: { SortPagerStore() })
    private lazy var viewStore = ViewStore(store, observe: { $0 })
    
    let componentView = ComponentView()
    let indicatorView = UIView()
    
    override func viewDidLoad() {
        addSubview(componentView)
        addSubview(indicatorView)
        componentView.animator = AnimatedReloadAnimator()
        backgroundColor = .background1
        
        indicatorView.backgroundColor = .primaryTintColor
        indicatorView.frame.size = CGSize(width: 20, height: 4)
        indicatorView.isHidden = true
        
        viewStore.publisher.sorts
            .sink { [weak self] sorts in
                guard let self = self else { return }
                self.componentView.component = Flow(alignItems: .center) {
                    HStack(spacing: 36, alignItems: .end) {
                        ForEach(sorts) { sort in
                            Text(sort.title, font: .medium(size: 13))
                                .textColor(.primaryLabel)
                                .tappableView { [weak self] in
                                    self?.pinSelectIndicator(to: sort)
                                }
                                .id(sort.title)
                                .if(sort.badgeNumber > 0) { text in
                                    text
                                        .badge(
                                            verticalAlignment: .before,
                                            horizontalAlignment: .after,
                                            offset: CGPoint(x: 0, y: 9)
                                        ) {
                                            FriendPageBadge(sort.badgeNumber)
                                        }
                                }
                        }
                    }
                }
                .inset(h: 32)
                if let sort = sorts.first, let frame = self.componentView.frame(id: sort.title), self.indicatorView.isHidden {
                    self.indicatorView.frame.origin = CGPoint(x: frame.center.x - 10, y: self.bounds.maxY - 4)
                    self.indicatorView.isHidden = false
                }
            }
            .store(in: &cancellables)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        componentView.frame = bounds
        indicatorView.cornerRadius = 2
    }
    
    func populate(sorts: [SortPagerParams]) {
        store.send(.configure(sorts))
    }
    
    private func pinSelectIndicator(to sort: SortPagerParams) {
        guard let frame = self.componentView.frame(id: sort.title) else { return }
        UIView.animate(withDuration: 0.2) {
            self.indicatorView.frame.origin = CGPoint(x: frame.center.x - 10, y: self.bounds.maxY - 4)
        }
    }
}


private struct FriendPageBadge: ComponentBuilder {
    
    private static var font = UIFont.medium(size: 12)
    
    var number: String
    var size: CGSize
    
    init(_ number: Int) {
        let numberString = number > 99 ? "99+" : "\(number)"
        let size = numberString.size(forFont: Self.font, maxWidth: 100)
        
        self.number = numberString
        if size.width < size.height {
            self.size = CGSize(width: size.height, height: size.height)
        } else {
            self.size = size
        }
    }
    
    func build() -> Component {
        Text(number, font: Self.font)
            .textColor(.white)
            .textAlignment(.center)
            .inset(top: 3.5, left: 3.5, bottom: 4.5, right: 4.5)
            .size(size.inset(by: -UIEdgeInsets(top: 3.5, left: 3.5, bottom: 4.5, right: 4.5)))
            .view()
            .backgroundColor(.softPink)
            .update {
                $0.cornerRadius = $0.frame.height / 2
            }
    }
}
