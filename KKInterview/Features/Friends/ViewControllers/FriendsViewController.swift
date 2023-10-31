//
//  FriendsViewController.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import FloatingPanel
import UIComponent

final class FriendsViewController: UIViewController {
    
    private let componentView = ComponentView()
    private var component: Component {
        VStack {
            PersonalInfoComponent()
            FriendPageComponent()
            FriendsPageIndicatorComponent()
            Separator(color: .primarySeparator)
            EmptyFriendsComponent()
        }
        .inset(v: 44)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingStyle()
        setupScrollView()
        setupNavigationHeaderCotroller()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        componentView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func bindingStyle() {
        view.backgroundColor = .white
    }
    
    private func setupScrollView() {
        view.addSubview(componentView)
        componentView.component = component
    }
    
    private func setupNavigationHeaderCotroller() {
        
        let content = NavigationHeaderViewController()
        let fpc = FloatingPanelController()
        fpc.layout = NavigationHeaderPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.panGestureRecognizer.isEnabled = false
        fpc.surfaceView.appearance.shadows = []
        fpc.surfaceView.grabberHandle.alpha = 0
        fpc.set(contentViewController: content)
        
        content.component = HStack(spacing: 24) {
            Image("ic_nav_pink_withdraw")
            Image("ic_nav_pink_transfer")
            Space().flex()
            Image("ic_navpink_scan")
        }
        .inset(h: 20)
    }
}
