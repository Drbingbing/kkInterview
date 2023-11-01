//
//  Color.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import UIComponent

public struct Color: ComponentBuilder {
    
    var color: UIColor
    var radius: CGFloat?
    
    public init(_ color: UIColor, radius: CGFloat? = nil) {
        self.color = color
        self.radius = radius
    }
    
    public func build() -> Component {
        UIView().then {
            $0.backgroundColor = color
            if let radius {
                $0.cornerRadius = radius
            }
        }
    }
}
