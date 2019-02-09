//
//  SettingsTableViewCell.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 9.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class SettingsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var visitDateLabel: UILabel!
    @IBOutlet weak var removedDateLabel: UILabel!
    @IBOutlet weak var isRemovedLabel: UILabel!

    override func setup<T>(_ data: T?) where T : SettingsRowViewModel {
        if let data = data {
            let history = data.history
            let topText = (history.visitedDate as Date?)?.toString() ?? ""

            visitDateLabel.text = "\("TRACK_ID".localized): \(history.trackId)\n\(topText)"
            removedDateLabel.text = (history.removedDate as Date?)?.toString() ?? ""
            isRemovedLabel.text = history.removed ? "DELETED".localized : (history.visited ? "VISITED".localized : "")
            isRemovedLabel.textColor = history.removed ? UIColor.red : Constants.Color.navbarForeground
        }
    }
    
}
