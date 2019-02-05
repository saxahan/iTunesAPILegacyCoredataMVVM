//
//  StoryboardBased.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

protocol StoryboardBased: class {
    func setup()
}

extension StoryboardBased where Self: UIViewController {
    static func instantiate(_ storyboardName: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))

        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Storyboard vc is not of class \(self)")
        }

        return vc
    }
}
