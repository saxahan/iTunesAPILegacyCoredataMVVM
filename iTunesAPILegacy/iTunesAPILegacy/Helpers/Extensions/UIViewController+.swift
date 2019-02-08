//
//  UIViewController+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIViewController {

    private static func instanceFromNib<T: UIViewController>(name: String? = nil) -> T {
        return T(nibName: name ?? String(describing: self), bundle: nil)
    }

    static func initFromNib(name: String? = nil) -> Self {
        return instanceFromNib(name: name)
    }
}
