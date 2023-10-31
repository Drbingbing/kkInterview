//
//  ColorView.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit

final class ColorView: UIView {
    
    convenience init(color: UIColor, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        backgroundColor = color
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
