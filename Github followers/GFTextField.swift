//
//  GFTextField.swift
//  Github followers
//
//  Created by rs on 23.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 10
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        minimumFontSize = 12
        adjustsFontSizeToFitWidth = true
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        placeholder = "Enter user name"
        autocorrectionType = .no
        backgroundColor = .tertiarySystemBackground
    }
    
}
