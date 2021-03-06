//
//  Date+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String = Constants.dateFormat) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
}
