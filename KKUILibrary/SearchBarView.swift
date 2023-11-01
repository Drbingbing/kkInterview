//
//  SearchBarView.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit

public final class SearchBarView: UIView {
    
    public let searchBar = UISearchBar()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        if size.width == .infinity {
            return searchBar.sizeThatFits(CGSize(width: 1000, height: size.height))
        }
        return searchBar.sizeThatFits(size)
    }
}
