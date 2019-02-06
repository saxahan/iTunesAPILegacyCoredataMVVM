//
//  MediaDetailViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class MediaDetailViewController: BaseViewController, ViewModelBased {

    var viewModel: MediaDetailViewModel!

    override func setup() {
        super.setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didAppeared?()
    }

    func bindings() {

    }

}
