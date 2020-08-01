//
//  GFItemInfoViewController.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFItemInfoViewController: UIViewController {
    
    let firstItemInfo = GFItemInfoView()
    let secondItemInfo = GFItemInfoView()
    let hstack = UIStackView()
    let button = GFButton()
    var user: User!
    
    init(user: User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        configureActionButton()
        layoutUI()
        configureStack()
    }
    
    @objc func actionButtonPressed() {}
    
    private func configureBackground() {
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureActionButton() {
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
    
    private func configureStack() {
        hstack.axis = .horizontal
        hstack.distribution = .equalSpacing
        hstack.addArrangedSubview(firstItemInfo)
        hstack.addArrangedSubview(secondItemInfo)
    }
    
    private func layoutUI() {
        view.addSubviews(hstack, button)
        
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            hstack.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            hstack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            hstack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            hstack.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: hstack.bottomAnchor, constant: padding),
            button.leadingAnchor.constraint(equalTo: hstack.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: hstack.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    

}
