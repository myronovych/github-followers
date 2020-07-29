//
//  GFAvatarImageView.swift
//  Github followers
//
//  Created by rs on 29.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholder = UIImage(named: "avatar-placeholder")
    
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
        image = placeholder
    }
    
    func setImage(urlString: String) {
        
        if let image = NetworkManager.shared.cache.object(forKey: NSString(string: urlString)) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if nil != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            NetworkManager.shared.cache.setObject(image, forKey: NSString(string: urlString))
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
    
    
}
