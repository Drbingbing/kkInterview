//
//  View.swift
//  KKUILibrary
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit

// base view class that provide viewDidLoad callback so that subclass don't need to implement two init functions
open class View: UIView {
    open var automaticallyCalculateShadowPath = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
        
        registerForTraitChanges(UITraitCollection.systemTraitsAffectingColorAppearance) { [weak self] (view: UIView, previousTraitCollection) in
            self?.traitCollectionChanged(previousTraitCollection)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }
    
    open func viewDidLoad() {
        // subclass override
    }
    
    open func traitCollectionChanged(_ previousTraitCollection: UITraitCollection) {
        // subclass override
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if layer.shadowOpacity > 0, automaticallyCalculateShadowPath {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        }
    }
    
    open override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        guard layer.shadowOpacity > 0, automaticallyCalculateShadowPath, event == "shadowPath" else {
            return super.action(for: layer, forKey: event)
        }
        
        guard let priorPath = layer.presentation()?.shadowPath ?? layer.shadowPath else {
            return super.action(for: layer, forKey: event)
        }
        
        guard let sizeAnimation = layer.animation(forKey: "bounds.size") as? CABasicAnimation else {
            return super.action(for: layer, forKey: event)
        }
        
        let animation = sizeAnimation.copy() as! CABasicAnimation
        animation.keyPath = "shadowPath"
        let action = ShadowingViewAction()
        action.priorPath = priorPath
        action.pendingAnimation = animation
        return action
    }
}

private class ShadowingViewAction: NSObject, CAAction {
    var pendingAnimation: CABasicAnimation? = nil
    var priorPath: CGPath? = nil
    
    // CAAction Protocol
    func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable: Any]?) {
        guard let layer = anObject as? CALayer, let animation = self.pendingAnimation else {
            return
        }
        
        animation.fromValue = self.priorPath
        animation.toValue = layer.shadowPath
        layer.add(animation, forKey: "shadowPath")
    }
}
