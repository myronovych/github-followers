//
//  GFFavoriteTableViewCell.swift
//  Github followers
//
//  Created by rs on 31.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFFavoriteTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "favoriteCell"
    let avatar = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(avatar)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 60),
            avatar.widthAnchor.constraint(equalToConstant: 60),
            avatar.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        avatar.setImage(urlString: favorite.avatarUrl)
    }
}
