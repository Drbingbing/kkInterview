//
//  FreindListCell.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import KKUILibrary
import KKLibrary
import KKApi
import ComposableArchitecture
import Combine
import BaseToolbox

class FreindListCell: UICollectionViewCell {
    
    let store = Store(initialState: FreindListCellStore.State(), reducer: { FreindListCellStore() })
    lazy var viewStore = ViewStore(store, observe: { $0 })
    
    private var cancellables: [AnyCancellable] = []
    
    private var transferButtonTrailingContraint: NSLayoutConstraint?
    
    @IBOutlet weak var starIconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var moreImageView: UIImageView!
    
    private let transferButton = WrapperView<UILabel>()
    private let inviteButton = WrapperView<UILabel>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.font = .regular(size: 16)
        nameLabel.textColor = .primaryLabel
        separator.backgroundColor = .secondarySeparator
        
        addSubview(transferButton)
        transferButton.translatesAutoresizingMaskIntoConstraints = false
        transferButton.contentView.font = .medium(size: 14)
        transferButton.borderWidth = 1.2
        transferButton.borderColor = .primaryTintColor
        transferButton.contentView.textColor = .primaryTintColor
        transferButton.contentView.text = "轉帳"
        transferButton.contentView.textAlignment = .center
        transferButton.cornerRadius = 2
        transferButton.widthAnchor.constraint(equalToConstant: 47).isActive = true
        transferButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        transferButtonTrailingContraint = transferButton.trailingAnchor.constraint(equalTo: moreImageView.leadingAnchor, constant: -25)
        transferButtonTrailingContraint?.isActive = true
        transferButton.centerYAnchor.constraint(equalTo: moreImageView.centerYAnchor).isActive = true
        
        addSubview(inviteButton)
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        inviteButton.contentView.font = .medium(size: 14)
        inviteButton.borderWidth = 1.2
        inviteButton.borderColor = .pinkishGray
        inviteButton.contentView.textColor = .brownGray
        inviteButton.contentView.text = "邀請中"
        inviteButton.contentView.textAlignment = .center
        inviteButton.cornerRadius = 2
        inviteButton.centerYAnchor.constraint(equalTo: moreImageView.centerYAnchor).isActive = true
        inviteButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        inviteButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        inviteButton.backgroundColor = .white
        inviteButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        viewStore.publisher
            .name
            .sink { [weak self] name in
                self?.nameLabel.text = name
            }
            .store(in: &cancellables)
        viewStore.publisher
            .isTop
            .sink { [weak self] isTop in
                self?.starIconView.isHidden = !isTop
            }
            .store(in: &cancellables)
        viewStore.publisher
            .status
            .sink { [weak self] status in
                guard let self = self else { return }
                self.transferButtonTrailingContraint?.constant = status == 2 ? -42 : -25
                self.inviteButton.isHidden = status != 2
                self.layoutIfNeeded()
            }
            .store(in: &cancellables)
    }

    func populate(person: Person) {
        store.send(.populate(person))
    }
}
