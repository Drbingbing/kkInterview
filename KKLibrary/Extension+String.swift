//
//  Extension+String.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit

extension String {
    
    public func size(forFont font: UIFont, maxWidth width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .zero)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.size
    }
}
