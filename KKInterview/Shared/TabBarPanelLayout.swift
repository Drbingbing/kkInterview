//
//  TabBarPanelLayout.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import UIKit
import FloatingPanel

final class TabBarPanelLayout: FloatingPanelLayout {
    
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring]
    
    init(height: CGFloat = 68.0) {
        anchors = [.tip: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .bottom, referenceGuide: .safeArea)]
    }
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0
    }
}
