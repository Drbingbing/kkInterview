//
//  TabBarPanelLayout.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import UIKit
import FloatingPanel

public final class TabBarPanelLayout: FloatingPanelLayout {
    
    public let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring]
    
    public init(height: CGFloat = 68.0) {
        anchors = [.tip: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .bottom, referenceGuide: .safeArea)]
    }
    
    public let position: FloatingPanelPosition = .bottom
    public let initialState: FloatingPanelState = .tip
    
    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0
    }
}
