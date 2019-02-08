//
//  BaseViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UInterfaceBased {

    let padding: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: setup some things
    
    func setup() {
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false

        initNavbar()
    }

    func initNavbar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
