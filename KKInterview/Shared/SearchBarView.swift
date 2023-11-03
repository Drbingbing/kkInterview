//
//  SearchBarView.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/10/31.
//

import UIKit

public final class SearchBarView: UIView {
    
    public let searchBar = UISearchBar()
    public let addFriendImageView = UIImageView(image: UIImage(named: "ic_btn_add_friends"))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addFriendImageView)
        addFriendImageView.translatesAutoresizingMaskIntoConstraints = false
        addFriendImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addFriendImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        addFriendImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        addFriendImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: addFriendImageView.leadingAnchor, constant: -15).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        searchBar.searchTextField.font = .regular(size: 14)
        searchBar.searchTextField.backgroundColor = .steel.withAlphaComponent(0.12)
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.searchTextField.font = .regular(size: 14)
        searchBar.searchBarStyle = .minimal
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
