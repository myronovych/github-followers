//
//  GFSecondaryTitleLabel.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    init(fontSize: CGFloat){
        super.init(frame: .zero)
        configure(fontSize: fontSize)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(fontSize: CGFloat) {
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        textColor = .secondaryLabel
        textAlignment = .natural
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
