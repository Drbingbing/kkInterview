//
//  FriendContentPanelLayout.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import FloatingPanel

final class FriendContentPanelLayout: FloatingPanelLayout {
    
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 44, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 152, edge: .top, referenceGuide: .safeArea)
        ]
    }
    
    var position: FloatingPanelPosition = .bottom
    var initialState: FloatingPanelState = .half
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0
    }
}
