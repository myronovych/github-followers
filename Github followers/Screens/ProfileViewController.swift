//
//  ProfileViewController.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: Follower!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        print(user.login)
    }
    

    private func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}
