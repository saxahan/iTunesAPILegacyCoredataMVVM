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

    // Numbers
    static let minimumSearchCharacter: Int = 0

    // Colors
    struct Color {
        static let background: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        static let visitedBackground: UIColor = #colorLiteral(red: 0.9960784314, green: 0.9019607843, blue: 0.06666666667, alpha: 0.6475847271)
        static let selectedBackground: UIColor = #colorLiteral(red: 0.9960784314, green: 0.9019607843, blue: 0.06666666667, alpha: 0.6475847271)
        static let navbarBackground: UIColor = #colorLiteral(red: 0.9960784314, green: 0.9019607843, blue: 0.06666666667, alpha: 1)
        static let navbarForeground: UIColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        static let tabBarBackground: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let tabBarForeground: UIColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        static let tabBarSelected: UIColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        static let primary: UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        static let secondary: UIColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
    }

    // Fonts
    struct Font {
        static let navbar: UIFont = UIFont.boldSystemFont(ofSize: 18)
        static let tabBar: UIFont = UIFont.systemFont(ofSize: 13)
        static let primaryButton: UIFont = UIFont.boldSystemFont(ofSize: 20)
    }
}
