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
        viewModel.visit?()
    }

    func bindings() {

    }

    override func initNavbar() {
        super.initNavbar()

        let deleteBtn = UIBarButtonItem.createButton(imageName: "trash", target: self, action: #selector(deleteTapped))
        navigationItem.rightBarButtonItem = deleteBtn
    }

    @objc func deleteTapped() {
        ConfirmationPopup.create(title: "POPUP_ARE_YOU_SURE_WANT_TO_DELETE".localized,
                                 topImage: #imageLiteral(resourceName: "error"),
                                 completion: { [weak self] state in
                                    if state == .yes {
                                        self?.navigationController?.popViewController(animated: true)
                                        self?.viewModel.delete?()
                                    }
        }).show()
    }
}
