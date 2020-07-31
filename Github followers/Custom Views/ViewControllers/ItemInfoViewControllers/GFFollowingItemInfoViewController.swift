//
//  GFFollowingItemInfoViewController.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFFollowingItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInfoItems()
        configureButton()
    }
    
    private func configureInfoItems() {
        firstItemInfo.set(itemInfoType: .followers, count: user.followers)
        secondItemInfo.set(itemInfoType: .following, count: user.following)
    }
    
    private func configureButton() {
        button.set(title: "Followers", backgroundColor: .systemGreen)
    }
    
    override func actionButtonPressed() {
        delegate.didPressGitHubFollowers(user: user)
    }
}
