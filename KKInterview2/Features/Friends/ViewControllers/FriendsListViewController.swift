//
//  FriendsListViewController.swift
//  KKInterview2
//
//  Created by 鍾秉辰 on 2023/11/2.
//

import UIKit
import ComposableArchitecture
import Combine
import KKLibrary
import KKApi

protocol FriendsListViewControllerDelegate: AnyObject {
    func didScrollViewScroll(_ scrollView: UIScrollView)
    func didRefresh(_ refreshControl: UIRefreshControl)
}

final class FriendsListViewController: UIViewController {
    
    private enum Section: Hashable {
        case main
    }
    
    let refreshControl = UIRefreshControl()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let store: StoreOf<FriendListStore> = Store(initialState: FriendListStore.State(), reducer: { FriendListStore() })
    lazy var viewStore: ViewStoreOf<FriendListStore> = ViewStore(store, observe: { $0 })
    
    weak var delegate: FriendsListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingStyle()
        bindingUI()
        binding()
        
    }
    
    private func bindingStyle() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
    }
    
    private func bindingUI() {
//        view.addSubview(emptyView)
//        
//        emptyView.translatesAutoresizingMaskIntoConstraints = false
//        emptyView.topAnchor.constraint(equalTo: view.topAnchor, constant: AppEnvironment.current.episode == .episode1 ? 0 : 75).isActive = true
//        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        emptyView.alpha = 0
//        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .primaryTintColor
        refreshControl.transform = .identity.scaledBy(0.6)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "FreindListCell", bundle: nil), forCellWithReuseIdentifier: "FreindListCell")
        collectionView.refreshControl = refreshControl
        collectionView.backgroundView = emptyView
    }
    
    private func binding() {
        viewStore.publisher.list
            .removeDuplicates()
            .sink { [weak self] list in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
                snapshot.appendSections([.main])
                snapshot.appendItems(list, toSection: .main)
                self.dataSource.apply(snapshot, animatingDifferences: true)
                
                UIView.animate(withDuration: 0.2) {
                    self.emptyView.alpha = list.isEmpty ? 1 : 0
                }
            }
            .store(in: &cancellables)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    @objc private func refresh() {
        delegate?.didRefresh(refreshControl)
    }
    
    // MARK: - Private properties
    private let emptyView = FriendEmptyView()
    private var cancellables: [AnyCancellable] = []
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Person>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FreindListCell", for: indexPath) as! FreindListCell
        cell.populate(person: itemIdentifier)
        return cell
    }
    
}

// MARK: - Public method
extension FriendsListViewController {
    
    public func populate(person: [Person]) {
        store.send(.configure(person))
    }
}

// MARK: - UICollectionViewDelegate
extension FriendsListViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScrollViewScroll(scrollView)
    }
}
