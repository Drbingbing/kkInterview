//
//  AddContactViewController.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/11/1.
//

import UIKit
import UIComponent
import FloatingPanel
import KKUILibrary

final class AddContactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
        bindingStyle()
        setupNavigationHeaderCotroller()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        componentView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
            Image("icNavibarBack")
                .tappableView { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
        }
        .inset(h: 20)
    }
    
    private func bindingUI() {
        view.addSubview(componentView)
        
        componentView.delaysContentTouches = false
        componentView.component = VStack {
            HStack {
                Text("留個聯絡方式", font: .medium(size: 26))
                Space(width: 1)
                    .flex()
                Text("3", font: .medium(size: 17))
                    .textColor(.primaryTintColor)
                Text(" / 4", font: .medium(size: 17))
                    .textColor(.pinkishGray)
            }
        }
    }
    
    private func bindingStyle() {
        view.backgroundColor = .background1
        componentView.backgroundColor = .clear
    }
    
    // MARK: - Private properties
    private let componentView = ComponentScrollView()
}
