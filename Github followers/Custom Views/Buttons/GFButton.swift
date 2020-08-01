//
//  GFButton.swift
//  Github followers
//
//  Created by rs on 23.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String, backgroundColor: UIColor){
        self.init(frame: .zero)
        set(title: title, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    public func set(title: String, backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    
}
