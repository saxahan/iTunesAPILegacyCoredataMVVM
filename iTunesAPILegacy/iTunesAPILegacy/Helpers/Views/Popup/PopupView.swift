//
//  PopupView.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class PopupView: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()

    convenience init(title: String?, message: String?, image: UIImage? = nil) {
        self.init(frame: UIScreen.main.bounds)
        setup(title: title, message: message, image: image)
    }

    private func setup(title: String?, message: String?, image: UIImage? = nil) {
        dialogView.clipsToBounds = true

        backgroundView.frame = frame
    }
}
