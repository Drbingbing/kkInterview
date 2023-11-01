//
//  NavigationHeaderPanelLayout.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/10/31.
//

import UIKit
import FloatingPanel

public final class NavigationHeaderPanelLayout: FloatingPanelLayout {
    
    public let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring]
    
    public init(height: CGFloat = 44.0) {
        anchors = [.tip: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .top, referenceGuide: .safeArea)]
    }
    
    public let position: FloatingPanelPosition = .top
    public let initialState: FloatingPanelState = .tip
    
    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0
    }
}
