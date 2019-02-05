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

// MARK: Refreshcontrol

extension UIScrollView {
    var _refreshControl : UIRefreshControl? {
        get {
            if #available(iOS 10.0, *) {
                return refreshControl
            } else {
                return subviews.first(where: { (view: UIView) -> Bool in
                    view is UIRefreshControl
                }) as? UIRefreshControl
            }
        }

        set {
            if #available(iOS 10.0, *) {
                refreshControl = newValue
            } else {
                // Unique instance of UIRefreshControl added to subviews
                if let oldValue = _refreshControl {
                    oldValue.removeFromSuperview()
                }
                if let newValue = newValue {
                    insertSubview(newValue, at: 0)
                }
            }
        }
    }

    func addRefreshControl(target: Any?, action: Selector) -> UIRefreshControl {
        let control = UIRefreshControl()
        addRefresh(control: control, target: target, action: action)
        return control
    }

    func addRefresh(control: UIRefreshControl, target: Any?, action: Selector) {
        if #available(iOS 9.0, *) {
            control.addTarget(target, action: action, for: .primaryActionTriggered)
        } else {
            control.addTarget(target, action: action, for: .valueChanged)
        }
        _refreshControl = control
    }
}
