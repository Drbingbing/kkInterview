//
//  FriendsViewController.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import FloatingPanel
import KKUILibrary

final class FriendsViewController: UIViewController {
    
    private weak var userHeaderViewController: UserHeaderViewController?
    private weak var navigationHeaderViewController: FriendsNavigationHeaderController?
    private weak var sortPagerViewController: SortPagerViewController?
    private let fpc = FloatingPanelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingStyle()
        setupNavigationHeaderController()
        setupUserHeaderViewController()
        setupSortPagerViewController()
        setupFriendListViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func bindingStyle() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationHeaderController() {
        let vc = FriendsNavigationHeaderController()
        let fpc = FloatingPanelController()
        fpc.layout = NavigationHeaderPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.panGestureRecognizer.isEnabled = false
        fpc.surfaceView.appearance.shadows = []
        fpc.surfaceView.grabberHandle.alpha = 0
        fpc.set(contentViewController: vc)
        
        navigationHeaderViewController = vc
    }
    
    private func setupUserHeaderViewController() {
        guard let navigationHeaderViewController else { return }
        let vc = UserHeaderViewController()
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: navigationHeaderViewController.view.bottomAnchor).isActive = true
        vc.view.heightAnchor.constraint(equalToConstant: 64).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        didMove(toParent: self)
        
        userHeaderViewController = vc
    }
    
    private func setupSortPagerViewController() {
        guard let userHeaderViewController else { return }
        let vc = SortPagerViewController()
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: userHeaderViewController.view.bottomAnchor).isActive = true
        vc.view.heightAnchor.constraint(equalToConstant: 44).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        didMove(toParent: self)
        
        sortPagerViewController = vc
    }
    
    private func setupFriendListViewController() {
        fpc.layout = FriendContentPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.panGestureRecognizer.isEnabled = false
        fpc.surfaceView.appearance.shadows = []
        fpc.surfaceView.grabberHandle.alpha = 0
        fpc.set(contentViewController: FriendsListViewController())
    }
}
