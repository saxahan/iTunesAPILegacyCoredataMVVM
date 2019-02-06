//
//  UIBarButtonItem+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createButton(imageName: String, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIView.createButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35), imageName: imageName, target: target, action: action)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
}
