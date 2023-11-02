//
//  FriendsNavigationHeaderController.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import KKUILibrary
import BaseToolbox

final class FriendsNavigationHeaderController: UIViewController {
    
    private let atmImageView = UIImageView()
        .then {
            $0.image = UIImage(named: "ic_nav_pink_withdraw")
        }
    
    private let moneyImageView = UIImageView()
        .then {
            $0.image = UIImage(named: "ic_nav_pink_transfer")
        }
    private let qrCodeImageView = UIImageView()
        .then {
            $0.image = UIImage(named: "ic_navpink_scan")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background1
        
        view.addSubview(atmImageView)
        view.addSubview(moneyImageView)
        view.addSubview(qrCodeImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        atmImageView.sizeToFit()
        atmImageView.frame.origin = CGPoint(x: 20, y: view.safeAreaInsets.top)
        moneyImageView.sizeToFit()
        moneyImageView.frame.origin = CGPoint(x: atmImageView.frame.maxX + 24, y: view.safeAreaInsets.top)
        qrCodeImageView.sizeToFit()
        qrCodeImageView.frame.origin = CGPoint(x: view.bounds.rightCenter.x - 44, y: view.safeAreaInsets.top)
    }
}
