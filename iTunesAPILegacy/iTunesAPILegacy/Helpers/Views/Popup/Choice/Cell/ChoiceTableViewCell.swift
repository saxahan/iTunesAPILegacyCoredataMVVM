//
//  ChoiceTableViewCell.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class ChoiceTableViewCell: BaseTableViewCell {

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        iconImgView.alpha = selected ? 1 : 0.1
    }

    func setup<T: FilterRowViewModel>(_ data: T?) {
        guard let data = data else { return }
        titleLbl.text = data.title

        if let imgName = data.imageName {
            iconImgView.image = UIImage(named: imgName)
        }

        iconImgView.alpha = isSelected ? 1 : 0.1
    }
}
