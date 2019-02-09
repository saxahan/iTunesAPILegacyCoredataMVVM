//
//  UIBarButtonItem+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createButton(imageName: String, alwaysTemplate: Bool = true, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIView.createButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35), imageName: imageName, alwaysTemplate: alwaysTemplate, target: target, action: action)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
}
