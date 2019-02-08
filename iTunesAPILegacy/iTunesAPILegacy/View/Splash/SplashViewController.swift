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

        // simulation as a demo
        // In general, we most likely do some async operations, like getting access token from a web service before any screen will be appeared.
        // Because of that, almost every app holder starts to begin designing fency splash screens for waiting situations.
        // Especially animated loaders, spinners etc...
        // My favorite library is Lottie because it just needs a tiny json file in order to play animation.
        // You can find lots of animation examples
        // here: https://lottiefiles.com/recent

        let appDelegate = UIApplication.appDelegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            appDelegate.startTabBased()
        }
    }

}
