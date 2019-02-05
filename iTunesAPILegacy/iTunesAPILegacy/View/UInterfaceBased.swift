//
//  UInterfaceBased.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

protocol UInterfaceBased: class {
    func setup()
}

extension UInterfaceBased where Self: UIViewController {
    static func instantiate() -> Self {
        let vc = Self.initFromNib()
        return vc
    }
}
