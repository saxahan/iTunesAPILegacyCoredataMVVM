//
//  MediaCollectionViewCell.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell, Settable {

    var viewModel: MediaCellViewModel?

    @IBOutlet weak var imgViewPreview: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(_ viewModel: CellViewModel) {
        guard let viewModel = viewModel as? MediaCellViewModel else { return }
        self.viewModel = viewModel

        if let prevUrl = self.viewModel?.previewUrl {
            imgViewPreview.setImage(prevUrl)
        }

        lblTitle?.text = self.viewModel?.name
    }
}
