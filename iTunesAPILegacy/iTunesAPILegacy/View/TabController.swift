//
//  TabController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {

    class func createTabBased(_ viewControllers: [BaseViewController] = []) -> TabController {
        let mediaListVc = MediaListViewController.instantiate(with: MediaListViewModel(), title: "TAB_SEARCH".localized, tabImage: #imageLiteral(resourceName: "search"))
        let settingsVc = SettingsViewController.instantiate(title: "TAB_SETTINGS".localized, tabImage: #imageLiteral(resourceName: "settings"))

        UITabBar.appearance().barTintColor = Constants.colorTabBarBackground
        UITabBar.appearance().tintColor = Constants.colorTabBarSelected
        UITabBar.appearance().isTranslucent = true

        let viewControllers = [mediaListVc, settingsVc]
        let tabs = viewControllers.map { (v) -> NavigationController in
            let navigator = NavigationController(navigationBarClass: ColorfulNavigationBar.self, toolbarClass: nil)
            navigator.setViewControllers([v], animated: false)
            return navigator
        }

        let tabBarController = TabController(tabs)

        return tabBarController
    }

    init(_ tabs: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = tabs
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK - UITabBarControllerDelegate

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.tabBarItem.badgeValue = nil
    }

    // MARK - Override this method in child classes.

    func setupViews() {
        delegate = self
        view.backgroundColor = Constants.colorBackground

        let selectedColor = Constants.colorTabBarSelected
        let unselectedColor = Constants.colorTabBarForeground
        let titleFont = Constants.fontTabBar

        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([.font: titleFont], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.font: titleFont], for: .selected)
    }
}
