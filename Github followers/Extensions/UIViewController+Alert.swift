//
//  UIViewController+Alert.swift
//  Github followers
//
//  Created by rs on 25.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlert(titleText: String, message: String, buttonText: String) {
        DispatchQueue.main.async {
            let ac = GFAlertViewController(titleText: titleText, message: message, buttonText: buttonText)
            
            ac.modalPresentationStyle = .overFullScreen
            ac.modalTransitionStyle = .crossDissolve
            
            self.present(ac, animated: true)
        }
    }
    
    func showLoadingScreen() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            containerView.alpha = 0.7
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activityIndicator.startAnimating()
        
    }
    
    func stopLoadingScreen() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
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
