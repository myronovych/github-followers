//
//  UIViewController+Alert.swift
//  Github followers
//
//  Created by rs on 25.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import SafariServices


extension UIViewController {
    
    func presentGFAlert(titleText: String, message: String, buttonText: String) {
        DispatchQueue.main.async {
            let ac = GFAlertViewController(titleText: titleText, message: message, buttonText: buttonText)
            
            ac.modalPresentationStyle = .overFullScreen
            ac.modalTransitionStyle = .crossDissolve
            
            self.present(ac, animated: true)
        }
    }
    
    func presentSafariView(withURL url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    func showEmptyStateView(message: String, view: UIView) {
        let emptyView = GFNoFollowersView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
    
    
}
