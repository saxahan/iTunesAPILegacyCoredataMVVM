//
//  XIBLocalizable.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 9.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

protocol XIBLocalizable {
    var xibLocalizable: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocalizable: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocalizable: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
}


