//
//  GFFollowerCollectionViewCell.swift
//  Github followers
//
//  Created by rs on 29.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFFollowerCollectionViewCell: UICollectionViewCell {
    static let cellID = "followerCell"
    
    let avatarView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        usernameLabel.text = follower.login
        avatarView.setImage(urlString: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
}
