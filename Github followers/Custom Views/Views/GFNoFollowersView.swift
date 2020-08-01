//
//  GFNoFollowersView.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFNoFollowersView: UIView {

    let textLabel = GFTitleLabel(textAlignment: .center, fontSize: 30)
    let image = UIImageView(image: Images.emptyStateLogo)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init()
        textLabel.text = message
    }
    
    private func configure() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(textLabel, image)
        
        textLabel.textColor = .secondaryLabel
        textLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            image.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            image.heightAnchor.constraint(equalToConstant: image.frame.width)
        ])
        
    }
    
}
