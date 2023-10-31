//
//  NavigationHeaderViewController.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent

final class NavigationHeaderViewController: UIViewController {
    
    private let componentView = ComponentScrollView()
    
    var component: Component? {
        get { componentView.component }
        set { componentView.component = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(componentView)
        view.backgroundColor = .background1
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        componentView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }
}
