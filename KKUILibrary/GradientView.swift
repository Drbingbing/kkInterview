//
//  GradientView.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit

open class GradientView: View {
    open override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    open var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    open var colors: [UIColor] = [] {
        didSet {
            guard colors != oldValue else { return }
            updateColors()
        }
    }
    
    open var locations: [CGFloat] = [] {
        didSet {
            gradientLayer.locations = locations as [NSNumber]
        }
    }
    
    open var startPoint: CGPoint {
        get { return gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }
    
    open var endPoint: CGPoint {
        get { return gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }
    
    open override func traitCollectionChanged(_ previousTraitCollection: UITraitCollection) {
        updateColors()
    }
    
    private func updateColors() {
        gradientLayer.colors = colors.map {
            $0.resolvedColor(with: traitCollection).cgColor
        }
    }
}
