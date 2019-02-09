//
//  BaseTableViewCell.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView = nil
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .gray

        let selectedBg = UIView(frame: contentView.frame)
        selectedBg.cornerRadius = 5
        selectedBg.backgroundColor = Constants.Color.selectedBackground
        selectedBackgroundView = selectedBg
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup<T: FilterRowViewModel>(_ data: T?) {

    }
}
