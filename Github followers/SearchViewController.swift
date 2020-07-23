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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogo()
        configureSearchField()
        configureSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        searchField.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }


}
