//
//  Popup.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class Popup: BaseViewController {
    
    var stateBlock: PopupCompletionState?
    var showAnimation: UIViewControllerAnimatedTransitioning? = PopupShowAnimation()
    var dismissAnimation: UIViewControllerAnimatedTransitioning? = PopupDismissAnimation()
    var shouldDismissTouchOutside: Bool = false

    private var showing: Bool = false
    var isShowing: Bool {
        return showing
    }

    // MARK: Inits

    init() {
        super.init(nibName: nil, bundle: nil)
        initBases()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initBases()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBases()
    }

    override func setup() {
        super.setup()
        view.backgroundColor = UIColor.clear

        // not implemented
//        if (self is ChoicePopup) == false {
//            let tapOutside = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
//            presented.view.addGestureRecognizer(tapOutside)
//        }
    }

    func show(above viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController, completion: (()-> Void)? = nil) {
        showing = true
        viewController?.present(self, animated: true, completion: completion)
    }

    func dismiss(_ completion: (()-> Void)? = nil) {
        dismiss(animated: true) {
            self.showing = false
            completion?()
        }
    }

    private func initBases() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    @objc func tappedOutside() {
        if shouldDismissTouchOutside {
            dismiss()
        }
    }
}

extension Popup: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {

        let controller = PopupPresentationController(presentedViewController: presented, presenting: presenting)
        controller.backViewColor = PopupAnimationProps.Color.backViewColor

        return controller
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return showAnimation
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
}
