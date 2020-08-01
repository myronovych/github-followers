//
//  GFProfileHeaderViewController.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFProfileHeaderViewController: UIViewController {
    
    var user: User!

    var avatarImage = GFAvatarImageView(frame: .zero)
    var usernameLabel = GFTitleLabel(textAlignment: .natural, fontSize: 34)
    var nameLabel = GFSecondaryTitleLabel(fontSize: 16)
    var locationLabel = GFSecondaryTitleLabel(fontSize: 16)
    var locationImageView = UIImageView(frame: .zero)
    var bioLabel = GFBodyLabel(textAlignment: .natural)
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        layoutElements()
        configureElements()
    }
    
    private func addElements() {
        view.addSubview(avatarImage)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(locationImageView)
        view.addSubview(bioLabel)
    }
    
    private func configureElements() {
        setAvatarImage()
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "No name"
        locationImageView.image = UIImage(systemName: SFSymbols.pin)
        locationImageView.tintColor = .secondaryLabel
        locationLabel.text = user.location ?? "No location"
        bioLabel.text = user.bio ?? "No bio"
        bioLabel.numberOfLines = 3
    }
    
    private func setAvatarImage() {
        NetworkManager.shared.downloadImage(urlString: user.avatarUrl) {[weak self] image in
            guard let image = image else {
                return
            }
            self?.avatarImage.image = image
        }
    }
    
    private func layoutElements() {
        let padding: CGFloat = 20
        let paddingToImage: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 90),
            avatarImage.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: paddingToImage),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: paddingToImage),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: paddingToImage),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: locationImageView.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: paddingToImage),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    


}
