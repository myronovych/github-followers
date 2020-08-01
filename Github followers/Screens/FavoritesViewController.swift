//
//  FavoritesViewController.swift
//  Github followers
//
//  Created by rs on 23.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var tableView = UITableView()
    var favorites = [Follower]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(GFFavoriteTableViewCell.self, forCellReuseIdentifier: GFFavoriteTableViewCell.reuseIdentifier)
        
        tableView.rowHeight = 80
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                guard favorites.count > 0 else {
                    self.showEmptyStateView(message: "No favorites at this moment :c", view: self.view)
                    
                    return
                }
                
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.presentGFAlert(titleText: "Error occured", message: error.rawValue, buttonText: "OK")
            }
        }
    }
    
    func configure() {
        showLoadingScreen()
        getFavorites()
        stopLoadingScreen()
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteTableViewCell.reuseIdentifier) as! GFFavoriteTableViewCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersListViewController(username: favorite.login)

        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(follower: favorite, action: .remove) {[weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlert(titleText: "Error occured", message: error.rawValue, buttonText: "OK")
            
        }
    }
    
    
}
