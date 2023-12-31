//
//  KKTabBarView.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import BaseToolbox
import KKUILibrary
import KKLibrary

final class KKTabBarView: UIView {
    
    private lazy var lineView = {
        let view = UIView()
        view.backgroundColor = .primarySeparator
        insertSubview(view, at: 0)
        return view
    }()
    
    private var items: [UIImage] = [] {
        didSet {
            imageViews = items.map { item in
                let view = WrapperView<UIImageView>()
                view.contentView.image = item
                return view
            }
        }
    }
    
    private var imageViews: [WrapperView<UIImageView>] = [] {
        didSet {
            subviews.forEach { $0.removeFromSuperview() }
            imageViews.forEach { addSubview($0) }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        render()
    }
    
    func populate(tabBarItemsData: TabBarItemsData) {

        items = tabBarItemsData.items.map { item in
            switch item {
            case .wallets:
                return UIImage(named: "ic_tabbar_products")
            case .friends:
                return UIImage(named: "ic_tabbar_friends")
            case .home:
                return UIImage(named: "ic_tabbar_home")
            case .management:
                return UIImage(named: "ic_tabbar_manage")
            case .setting:
                return UIImage(named: "ic_tabbar_setting")
            }
        }.compactMap { $0 }
    }
    
    private func render() {
        lineView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
        
        let totalWidth = imageViews.reduce(CGFloat(0)) { partialResult, imageView in
            let size = imageView.sizeThatFits(bounds.size)
            return partialResult + size.width
        }
        
        let spacing = (bounds.width - totalWidth) / CGFloat(items.count + 1)
        
        var origin: CGPoint = CGPoint(x: spacing, y: 5)
        for index in 0..<imageViews.count {
            let item = imageViews[index]
            let size = item.sizeThatFits(bounds.size)
            item.frame = CGRect(origin: index == 2 ? CGPoint(x: origin.x, y: origin.y - 18) : origin, size: size)
            origin.x += size.width + spacing
        }
    }
}
