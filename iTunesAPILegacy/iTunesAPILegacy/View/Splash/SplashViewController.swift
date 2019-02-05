//
//  SplashViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    override func setup() {
        super.setup()

        let appDelegate = UIApplication.appDelegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            appDelegate.startTabBased()
        }
    }

}
