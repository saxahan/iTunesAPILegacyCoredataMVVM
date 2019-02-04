//
//  String+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ") -> Date? {
        return DateFormatter(format: format).date(from: self)
    }

    func toDateString(inputFormat: String, outputFormat: String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
        }
        return nil
    }
}
