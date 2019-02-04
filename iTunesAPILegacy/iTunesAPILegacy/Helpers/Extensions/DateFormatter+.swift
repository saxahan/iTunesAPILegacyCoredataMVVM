//
//  DateFormatter+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
