//
//  PopupAnimation.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class PopupShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 0.8
    var delay: TimeInterval = 0.0
    var springWithDamping: CGFloat = 0.8
    var springVelocity: CGFloat = 2.0

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view( forKey: UITransitionContextViewKey.to)
            else {
                return
        }

        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: toViewController)
        containerView.addSubview(toView)

        toView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: springWithDamping,
                       initialSpringVelocity: springVelocity,
                       options: .curveEaseInOut, animations: {
                        toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}

class PopupDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 0.2
    var delay: TimeInterval = 0.0

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view( forKey: UITransitionContextViewKey.from)
            else {
                return
        }

        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: {
                        fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                        fromView.alpha = 0.0
        }) { (finished) in
            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            fromView.alpha = 1.0
            transitionContext.completeTransition(finished)
        }
    }
}

