//
//  ResultsViewController.swift
//  Github followers
//
//  Created by rs on 25.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var page = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
        configureSearchController()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnsLayout(in: view))
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(GFFollowerCollectionViewCell.self, forCellWithReuseIdentifier: GFFollowerCollectionViewCell.cellID)
        
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func getFollowers(page: Int) {
        showLoadingScreen()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.stopLoadingScreen()
            
            
            
            switch result {
            case .success(let followers):
                self.followers.append(contentsOf: followers)
                if followers.count == 0 {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(message: "This user has no followers😟", view: self.view)
                    }
                    
                    return
                }
                self.updateData(on: followers)
                if followers.count < 100 { self.hasMoreFollowers = false}
                
            case .failure(let error):
                self.presentGFAlert(titleText: "Error", message: error.rawValue, buttonText: "OK")
            }
            
            
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCollectionViewCell.cellID, for: indexPath) as! GFFollowerCollectionViewCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter username"
        navigationItem.searchController = searchController
    }
    
    func updateData(on: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(on)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    func showEmptyStateView(message: String, view: UIView) {
        let emptyView = GFNoFollowersView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
    
}

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height && hasMoreFollowers {
            page += 1
            getFollowers(page: page)
        }
    }
}

extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            return
            
        }

        let filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
    
    
}
