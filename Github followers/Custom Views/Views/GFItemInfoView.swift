//
//  GFItemInfoView.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    
    var iconImageView = UIImageView()
    var titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    var countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = titleLabel.tintColor
        iconImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, count: Int) {
        switch itemInfoType {
        case .repos:
            iconImageView.image = UIImage(named: SFSymbols.repos)
            titleLabel.text = "Repos"
        case .gists:
            iconImageView.image = UIImage(named: SFSymbols.gist)
            titleLabel.text = "Gists"
        case .followers:
            iconImageView.image = UIImage(named: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            iconImageView.image = UIImage(named: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
}
