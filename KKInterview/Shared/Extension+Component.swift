//
//  Extension+Component.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit
import UIComponent

public extension Component {
    
    func shadow() -> ViewUpdateComponent<ComponentViewComponent<ComponentView>> {
        view()
            .update {
                $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
                $0.layer.shadowOffset = CGSize(width: 0, height: 4)
                $0.layer.shadowRadius = 8
                $0.layer.shadowOpacity = 1
            }
    }
}
