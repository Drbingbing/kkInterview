//
//  UserHeaderViewController.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import KKUILibrary
import BaseToolbox

final class UserHeaderViewController: UIViewController {
    
    private let avatorView = WrapperView<UIImageView>()
        .then {
            $0.contentView.image = UIImage(named: "img_friends_female_default")
        }
    
    private let stackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 8
        }
    
    private let nameLabel = WrapperView<UILabel>()
        .then {
            $0.contentView.text = "子霖"
            $0.contentView.textColor = .primaryLabel
            $0.contentView.font = .medium(size: 17)
        }
    
    private let subtitleLabel = WrapperView<UILabel>()
        .then {
            $0.contentView.text = "設定 KOKO ID"
            $0.contentView.textColor = .primaryLabel
            $0.contentView.font = .regular(size: 13)
        }
    
    private let arrowImage = WrapperView<UIImageView>()
        .then {
            $0.contentView.image = UIImage(named: "arrow_right_deep_gray")
        }
    
    private let circleImage = WrapperView<UIView>()
        .then {
            $0.backgroundColor = .primaryTintColor
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background1
        
        view.addSubview(avatorView)
        
        avatorView.translatesAutoresizingMaskIntoConstraints = false
        avatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        avatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        avatorView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        avatorView.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        view.addSubview(arrowImage)
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.leadingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 18).isActive = true
        arrowImage.widthAnchor.constraint(equalToConstant: 18).isActive = true
        
        view.addSubview(circleImage)
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.leadingAnchor.constraint(equalTo: arrowImage.trailingAnchor, constant: 15).isActive = true
        circleImage.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor).isActive = true
        circleImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        circleImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circleImage.cornerRadius = circleImage.frame.height / 2
    }
}
