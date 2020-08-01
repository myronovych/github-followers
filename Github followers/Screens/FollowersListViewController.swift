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
    var isSearching = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
        configureSearchController()
        configureAddButton()
    }
    
    func configureAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
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
                
                self.updateData(on: self.followers)
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
        searchController.obscuresBackgroundDuringPresentation = false
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
    
    
    
    @objc func addButtonPressed() {
        showLoadingScreen()
        NetworkManager.shared.getUser(username: username) { [weak self] result in
            guard let self = self else { return }
            self.stopLoadingScreen()

            switch result {
            case .success(let user):
                let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(follower: follower, action: .add) {[weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlert(titleText: "Success", message: "You added user to your favorites <3", buttonText: "Nice!")
                        return
                    }
                    self.presentGFAlert(titleText: "Something went wrong", message: error.rawValue, buttonText: "OK")
                }
            case .failure(let error):
                self.presentGFAlert(titleText: "Something went wrong", message: error.rawValue, buttonText: "OK")
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        
        let profileVC = ProfileViewController()
        profileVC.user = selectedUser
        profileVC.delegate = self
        
        let navVC = UINavigationController(rootViewController: profileVC)
        
        present(navVC, animated: true)
    }
}

extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            return
            
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
    
    
}

protocol FollowersListViewControllerDelegate: class {
    func requestFollowers(for user: User)
}

extension FollowersListViewController: FollowersListViewControllerDelegate {
    func requestFollowers(for user: User) {
        username = user.login
        title = username
        page = 1
        hasMoreFollowers = true
        isSearching = false
        followers.removeAll()
        filteredFollowers.removeAll()
        getFollowers(page: 1)
    }
    
    
}
