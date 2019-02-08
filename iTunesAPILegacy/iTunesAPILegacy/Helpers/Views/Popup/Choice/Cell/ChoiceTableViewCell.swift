//
//  ChoiceTableViewCell.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class ChoiceTableViewCell: BaseTableViewCell<RowViewModel> {

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        iconImgView.alpha = selected ? 1 : 0.1
    }

    override func setup(_ row: RowViewModel?) {
        guard let row = row else { return }

        titleLbl.text = row.title
        iconImgView.image = UIImage(named: row.imageName)
        iconImgView.alpha = isSelected ? 1 : 0.1
    }
}
