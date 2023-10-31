//
//  SearchBarView.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit

final class SearchBarView: UIView {
    
    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if size.width == .infinity {
            return searchBar.sizeThatFits(CGSize(width: 1000, height: size.height))
        }
        return searchBar.sizeThatFits(size)
    }
}
