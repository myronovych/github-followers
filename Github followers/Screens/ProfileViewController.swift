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
    
    var headerView = UIView()
    var firstView = UIView()
    var secondView = UIView()
    var dateLabel = GFBodyLabel(textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getInfo() 
        layoutUI()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }
    
    private func getInfo() {
        NetworkManager.shared.getUser(username: user.login) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFProfileHeaderViewController(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemViewController(user: user), to: self.firstView)
                    self.add(childVC: GFFollowingItemViewController(user: user), to: self.secondView)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToMonthDay())"
                }
                print(user)
            case .failure(let error):
                self.presentGFAlert(titleText: "Error", message: error.rawValue, buttonText: "OK")
            }
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func layoutUI() {
        let views = [headerView, firstView, secondView, dateLabel]
        let padding: CGFloat = 20

        for item in views {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            firstView.heightAnchor.constraint(equalToConstant: 140),
            firstView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            
            secondView.heightAnchor.constraint(equalToConstant: 140),
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: padding),
            
            dateLabel.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
