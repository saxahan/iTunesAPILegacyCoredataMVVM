//
//  Constants.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

struct Constants {
    
    // Strings
    static let dateMappingFormat: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    static let dateFormat: String = "dd MMM YYYY HH:mm"
    static let coreDataDatabaseName: String = "iTunesAPILegacy"

    // Colors
    static let colorBackground: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    static let colorNavbarBackground: UIColor = #colorLiteral(red: 0.9960784314, green: 0.9019607843, blue: 0.06666666667, alpha: 1)
    static let colorNavbarForeground: UIColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
    static let colorTabBarBackground: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let colorTabBarForeground: UIColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
    static let colorTabBarSelected: UIColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)

    // Fonts
    static let fontNavbar: UIFont = UIFont.boldSystemFont(ofSize: 18)
    static let fontTabBar: UIFont = UIFont.systemFont(ofSize: 13)
}
