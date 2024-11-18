//
//  UIViewController+Ext.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 30/09/24.
//

import UIKit
import SafariServices

// We cannot create a view inside extension, but we can access the fileprivate variable inside the extensions
// Created a UIView to show the loader
fileprivate var containerView: UIView!

extension UIViewController {

    // extension of viewcontroller to show custom alert whereever we want
    func presentGFAlertOnMainThread(title: String, message : String, buttonTitle : String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    // Show activityIndicator with 0.8 opacity UIView while loading data
    func showLoadingView(){
        // create a container view with full screen
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView) // add containerView into view

        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0

        // Animate the loader while showing for 0.25 sec from 0 to 0.8 opacity
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }

        // Create a large activity indicator and add it into containerView
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        // Set the translatesAutoresizingMaskIntoConstraints to false, so that it will not displace from it position
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        // This indicator does not require four constraints, because we want to place this indicator in center of the View
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        // start animating the indicator
        activityIndicator.startAnimating()
    }

    // Dismiss indicator function
    func dismissLoadingView(){
        // Perform this operation on the main thread
        DispatchQueue.main.async {
            // remove the containerView from the superview
            containerView.removeFromSuperview()
            containerView = nil
        }
    }

    func showEmptyStateView(with message: String,in view: UIView){
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

    func presentSafariVC(with url:URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
