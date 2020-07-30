//
//  GFRepoItemViewController.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {
    
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
}
