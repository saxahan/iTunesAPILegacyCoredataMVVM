//
//  ViewModelBased.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

protocol ViewModelBased: class {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
    func bindings()
}

extension ViewModelBased where Self: UInterfaceBased & UIViewController {
    static func instantiate(title: String?, tabImage: UIImage? = nil) -> Self {
        let viewController = Self.instantiate()
        viewController.title = title

        let tabItem = UITabBarItem(title: title, image: tabImage, selectedImage: tabImage)
        viewController.tabBarItem = tabItem

        return viewController
    }

    static func instantiate(with viewModel: ViewModel, title: String?, tabImage: UIImage? = nil) -> Self {
        let viewController = Self.instantiate()
        viewController.title = title
        viewController.viewModel = viewModel

        let tabItem = UITabBarItem(title: title, image: tabImage, selectedImage: tabImage)
        viewController.tabBarItem = tabItem

        return viewController
    }
}
