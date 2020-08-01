//
//  GFRepoItemViewController.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

protocol RepoItemInfoDelegate: class {
    func didPressGitHubProfile(user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
    
    var delegate: RepoItemInfoDelegate!
    
    init(user: User, delegate: RepoItemInfoDelegate? = nil) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInfoItems()
        configureButton()
    }
    
    private func configureInfoItems() {
        firstItemInfo.set(itemInfoType: .repos, count: user.publicRepos)
        secondItemInfo.set(itemInfoType: .gists, count: user.publicGists)
    }
    
    private func configureButton() {
        button.set(title: "GitHub profile", backgroundColor: .systemPurple)
    }
    
    override func actionButtonPressed() {
        delegate.didPressGitHubProfile(user: user)
    }
    

}
