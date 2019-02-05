//
//  BaseViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UInterfaceBased {

//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    init(titleText: String = "", _ image: String = "", _ selectedImage: String = "") {
//        super.init(nibName: nil, bundle: nil)
//
//        self.title = titleText
//        let tabItem = UITabBarItem(title: titleText, image: UIImage(named: image), selectedImage: UIImage(named: selectedImage))
//        self.tabBarItem = tabItem
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: setup some things
    
    func setup() {
        
    }
}
