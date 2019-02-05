//
//  UIScrollView+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIScrollView {
    func showIndicator(_ color: UIColor = .gray) {
        if self.viewWithTag(65) == nil {
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            activityIndicator.tag = 65
            activityIndicator.color = color
            activityIndicator.startAnimating()
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false

            self.addSubview(activityIndicator)

            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                ])
        }
    }

    func hideIndicator() {
        if let activityIndicator = self.viewWithTag(65) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
        }
    }
}
