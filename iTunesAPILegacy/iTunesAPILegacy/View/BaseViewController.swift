//
//  BaseViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, StoryboardBased {
    
    var storyboardName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: setup some things
    
    func setup() {

    }
}
