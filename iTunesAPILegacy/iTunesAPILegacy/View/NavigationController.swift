//
//  NavigationController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

// This is my older navigation class
// I used a dictionary for properties, but using enum case values will be fit better.

class ColorfulNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        isTranslucent = false
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NavigationController: UINavigationController {

    var shouldChangeParams: Bool = true
    var navbarParams: [String: AnyObject]! {
        didSet {

            var bgColor: UIColor = Constants.Color.navbarBackground
            if let backgroundColor = navbarParams["backgroundColor"] as? UIColor {
                bgColor = backgroundColor
            }

            navigationBar.barTintColor = bgColor

            var fgColor: UIColor = Constants.Color.navbarForeground
            if let foregroundColor = navbarParams["foregroundColor"] as? UIColor {
                fgColor = foregroundColor
            }

            navigationBar.tintColor = fgColor
            navigationBar.titleTextAttributes = [.foregroundColor: fgColor]

            if let logo = navbarParams["titleLogo"] as? UIView {
                navigationBar.topItem?.titleView = logo
            }

            var titleFont = Constants.Font.navbar
            if let font = navbarParams["titleFont"] as? UIFont {
                titleFont = font
            }

            navigationBar.titleTextAttributes = [
                .font: titleFont,
                .foregroundColor: fgColor
            ]

            navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = bgColor == .clear
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if shouldChangeParams {
            navbarParams = [:]
        }
        super.pushViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        if shouldChangeParams {
            navbarParams = [:]
        }
        return super.popViewController(animated: animated)
    }

    // MARK: Navigation stylers

    func setup() {        
        if navbarParams == nil, shouldChangeParams {
            navbarParams = [:]
        }
    }

    @objc func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }

}
