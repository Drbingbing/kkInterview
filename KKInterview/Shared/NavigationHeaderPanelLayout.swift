//
//  NavigationHeaderPanelLayout.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import FloatingPanel

final class NavigationHeaderPanelLayout: FloatingPanelLayout {
    
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring]
    
    init(height: CGFloat = 44.0) {
        anchors = [.tip: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .top, referenceGuide: .safeArea)]
    }
    
    let position: FloatingPanelPosition = .top
    let initialState: FloatingPanelState = .tip
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0
    }
}
