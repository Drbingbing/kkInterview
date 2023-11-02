//
//  FriendsListViewController.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit

final class FriendsListViewController: UIViewController {
    
    private let emptyView = FriendEmptyView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FreindListCell", for: indexPath) as! FreindListCell
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingStyle()
        bindingUI()
//        view.addSubview(emptyView)
//        
//        emptyView.translatesAutoresizingMaskIntoConstraints = false
//        emptyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bindingStyle() {
        
    }
    
    private func bindingUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: "FreindListCell", bundle: nil), forCellWithReuseIdentifier: "FreindListCell")
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(0..<20))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .plain))
    }
}
