//
//  AddContactViewController.swift
//  KKInterview
//
//  Created by Bing Bing on 2023/11/1.
//

import UIKit
import UIComponent
import FloatingPanel
import KKUILibrary

protocol AddContactViewControllerDelegate: AnyObject {
    func didBackButtonTapped(_ viewController: AddContactViewController)
    func didCloseButtonTapped(_ viewController: AddContactViewController)
}

final class AddContactViewController: UIViewController {
    
    weak var delegate: AddContactViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
        bindingStyle()
        setupNavigationHeaderCotroller()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        componentView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupNavigationHeaderCotroller() {
        
        let content = FloatingContentViewController()
        let fpc = FloatingPanelController()
        fpc.layout = NavigationHeaderPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.panGestureRecognizer.isEnabled = false
        fpc.surfaceView.appearance.shadows = []
        fpc.surfaceView.grabberHandle.alpha = 0
        fpc.set(contentViewController: content)
        
        content.component = HStack(spacing: 24) {
            Image("icNavibarBack")
                .tappableView { [weak self] in
                    guard let self else { return }
                    self.delegate?.didBackButtonTapped(self)
                }
            Space().flex()
            Image("ic_navibar_close")
                .tappableView { [weak self] in
                    guard let self else { return }
                    self.delegate?.didCloseButtonTapped(self)
                }
        }
        .inset(h: 20)
    }
    
    private func bindingUI() {
        view.addSubview(componentView)
        
        componentView.delaysContentTouches = false
        componentView.component = VStack {
            HStack {
                Text("留個聯絡方式", font: .medium(size: 26))
                    .textColor(.primaryLabel)
                Space(width: 1)
                    .flex()
                Text("3", font: .medium(size: 17))
                    .textColor(.primaryTintColor)
                Text(" / 4", font: .medium(size: 17))
                    .textColor(.pinkishGray)
            }
            Space(height: 2)
            Text("確認一下通訊資料，並讓我們知道如何與你聯繫：）", font: .regular(size: 14))
                .textColor(.brownGray)
            Space(height: 30)
            HStack(spacing: 22, alignItems: .center) {
                Image("img_apply_contact")
                VStack(spacing: 12) {
                    VStack(spacing: 2) {
                        Text("戶籍地址", font: .medium(size: 13))
                        Text("台北市信義區松仁路 7 號", font: .regular(size: 13))
                    }
                    VStack(spacing: 2) {
                        Text("電子信箱", font: .medium(size: 13))
                        Text("olylinhuang@gmail.com", font: .regular(size: 13))
                    }
                    VStack(spacing: 2) {
                        Text("手機號碼", font: .medium(size: 13))
                        Text("0911928368", font: .regular(size: 13))
                    }
                }
            }
            .size(width: .fill)
            .inset(top: 16, left: 20, bottom: 14)
            .view()
            .backgroundColor(.background2)
            .cornerRadius(6)
            .shadow(radius: 4)
            
            Space(height: 43)
            
            HStack(spacing: 16) {
                MenuComponent(title: "居住縣市")
                    .flex()
                MenuComponent(title: "行政區")
                    .flex()
            }
            
            Space(height: 43)
            
            MenuComponent(title: "居住地址")
                .size(width: .fill)
            
            Space(height: 43)
            
            HStack(spacing: 16) {
                MenuComponent(title: "區碼")
                MenuComponent(title: "住家電話", showArrow: false)
                    .flex()
            }
            
            Space(height: 43)
            
            MenuComponent(title: "房屋所有權")
                .size(width: .fill)
            
            Space(height: 43)
            
            MenuComponent(title: "現居時間")
                .size(width: .fill)
            
            Space(height: 43)
            
            MenuComponent(title: "卡片/帳單收件地址")
                .size(width: .fill)
            
            Space(height: 30)
            
            Image("img_check_dialog")
                .badge(verticalAlignment: .start, horizontalAlignment: .end) {
                    Text(attributedString: terms)
                        .size(width: 192, height: 54)
                        .offset(x: -16.2, y: 18)
                }
            
            Space(height: 25)
            
            VStack(spacing: 12) {
                HStack(spacing: 12, alignItems: .center) {
                    Image("ic_radio_btn_n")
                    Text("同意，放心交給 KOKO：）", font: .regular(size: 13))
                        .textColor(.primaryLabel)
                }
                .inset(h: 20)
                
                HStack(spacing: 12, alignItems: .center) {
                    Image("ic_radio_btn_n")
                    Text("不同意，我不想知道國泰集團的優惠訊息", font: .regular(size: 13))
                        .textColor(.primaryLabel)
                }
                .inset(h: 20)
            }
            
            Space(height: 31)
            
            Separator(color: .secondarySeparator)
            
            Space(height: 15)
            
            HStack(alignItems: .center) {
                Text("進一步看看相關條款", font: .regular(size: 13))
                Space().flex()
                Image(systemName: "chevron.down")
                    .tintColor(.primaryTintColor)
            }
        }
        .inset(top: 44, left: 20, bottom: 122, right: 20)
        .badge(verticalAlignment: .end, horizontalAlignment: .end, offset: CGPoint(x: -20, y: 0)) {
            GradientView()
                .then {
                    $0.startPoint = CGPoint(x: 0, y: 0.5)
                    $0.endPoint = CGPoint(x: 1, y: 0.5)
                    $0.colors = [.frogGreen, .boogerGreen]
                    $0.cornerRadius = 30
                }
                .size(width: 60, height: 60)
                .overlay {
                    Image(systemName: "arrow.forward")
                        .tintColor(.white)
                        .inset(15)
                }
        }
    }
    
    private func bindingStyle() {
        view.backgroundColor = .background1
        componentView.backgroundColor = .clear
    }
    
    private var terms: NSAttributedString {
        let a = NSAttributedString(
            string: "考量個人的隱私權益，想確認你是否同意 ",
            attributes: [.font: UIFont.regular(size: 13), .foregroundColor: UIColor.brownGray]
        )
        let b = NSAttributedString(
            string: "個資保護法告知內容第六點個別條款?",
            attributes: [
                .font: UIFont.regular(size: 13),
                .underlineColor: UIColor.primaryTintColor,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.primaryTintColor,
            ]
        )
        
        let result = NSMutableAttributedString(attributedString: a)
        result.append(b)
        
        return result
    }
    
    // MARK: - Private properties
    private let componentView = ComponentScrollView()
}

private struct MenuComponent: ComponentBuilder {
    
    var title: String
    var showArrow: Bool
    
    init(title: String, showArrow: Bool = true) {
        self.title = title
        self.showArrow = showArrow
    }
    
    func build() -> Component {
        HStack(alignItems: .center) {
            Text(title, font: .regular(size: 17))
                .textColor(.tertitaryLabel)
            Space(width: 8).flex()
            if showArrow {
                Image(systemName: "chevron.down")
                    .tintColor(.primaryLabel)
            }
        }
        .inset(h: 15, v: 8)
        .capsule()
        .backgroundColor(.white)
        .shadow(radius: 4)
    }
}
