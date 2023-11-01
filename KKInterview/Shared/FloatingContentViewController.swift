//
//  FloatingContentViewController.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent

public final class FloatingContentViewController: UIViewController {
    
    private let componentView = ComponentScrollView()
    
    public var component: Component? {
        get { componentView.component }
        set { componentView.component = newValue }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(componentView)
        view.backgroundColor = .background1
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        componentView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }
}
