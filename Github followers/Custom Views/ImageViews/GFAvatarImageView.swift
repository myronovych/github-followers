//
//  GFAvatarImageView.swift
//  Github followers
//
//  Created by rs on 29.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    static let placeholder = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        clipsToBounds = true
        image = GFAvatarImageView.placeholder
    }
    
    
    
    
}
