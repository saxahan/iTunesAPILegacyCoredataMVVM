//
//  PopupPresentationController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class PopupPresentationController: UIPresentationController {
    var backViewColor = PopupAnimationProps.Color.backViewColor {
        didSet {
            backgroundView.backgroundColor = backViewColor
        }
    }

    private lazy var backgroundView = UIView(frame: CGRect.zero)

    override func presentationTransitionWillBegin() {
        if let containerView = containerView {
            containerView.insertSubview(backgroundView, at: 0)

            backgroundView.translatesAutoresizingMaskIntoConstraints = false

            // layout
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])

            runBackgroundAnimation()
        }
    }

    override func dismissalTransitionWillBegin() {
        runBackgroundAnimation()
    }

    override var shouldRemovePresentersView: Bool {
        return false
    }

    // MARK: Private Methods

    fileprivate func runBackgroundAnimation() {
        backgroundView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.backgroundView.alpha = 1
            }, completion: nil)
        }
    }

    fileprivate func excuteBackgroundDismissAnimation() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
}
