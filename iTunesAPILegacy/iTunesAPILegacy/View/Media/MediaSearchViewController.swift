//
//  MediaSearchViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class MediaSearchViewController: BaseViewController, ViewModelBased {
    
    var viewModel: MediaSearchViewModel!

    override func setup() {
        super.setup()

        viewModel.search("matrix", entity: .podcast)
    }
}
