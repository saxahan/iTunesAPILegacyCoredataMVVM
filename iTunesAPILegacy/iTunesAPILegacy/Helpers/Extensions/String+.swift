//
//  String+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String = Constants.dateMappingFormat) -> Date? {
        return DateFormatter(format: format).date(from: self)
    }

    func toDateString(inputFormat: String, outputFormat: String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
        }
        return nil
    }

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func highlightWords(in highlightedWords: String, attributes: [[NSAttributedString.Key: Any]]) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: highlightedWords)
        let result = NSMutableAttributedString(string: self)

        for attribute in attributes {
            result.addAttributes(attribute, range: range)
        }

        return result
    }
}
