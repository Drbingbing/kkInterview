//
//  SortPagerViewController.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import BaseToolbox
import KKUILibrary

final class SortPagerViewController: UIViewController {
    
    private var indicatorLeadingConstraint: NSLayoutConstraint?
    
    private let scrollView = UIScrollView()
    private let indicatorView = UIView()
        .then {
            $0.backgroundColor = .primaryTintColor
        }
    
    private let stackView = UIStackView()
        .then {
            $0.axis = .horizontal
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background1
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let mock = UILabel()
        mock.text = "好友"
        mock.textColor = .primaryLabel
        mock.font = .medium(size: 13)
        stackView.addArrangedSubview(mock)
        stackView.addArrangedSubview(UIView())
        
        view.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerXAnchor.constraint(equalTo: mock.centerXAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        indicatorView.cornerRadius = indicatorView.frame.height / 2
    }
}
