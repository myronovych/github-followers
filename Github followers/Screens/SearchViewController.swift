//
//  SearchViewController.swift
//  Github followers
//
//  Created by rs on 23.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logo = UIImageView()
    let searchField = GFTextField()
    let searchButton = GFButton(title: "Get followers", backgroundColor: .systemGreen)
    
    var isUsernameEntered: Bool {
        return !searchField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogo()
        configureSearchField()
        configureSearchButton()
        configureDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func pushFollowersListVC(){
        guard isUsernameEntered else {
            presentGFAlert(titleText: "Empty search field", message: "We have to know for who to look :)", buttonText: "OK")
            
            return
        }
        
        
        
        let followersListVC = FollowersListViewController()
        followersListVC.username = searchField.text!
        followersListVC.title = searchField.text!
        
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    func configureDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer.init(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    private func configureLogo() {
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        logo.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 200),
            logo.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureSearchField() {
        view.addSubview(searchField)
        searchField.delegate = self
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}


