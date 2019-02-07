//
//  PopupViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

enum PopupType {
    case info
    case warning
    case error
    case success
}

enum PopupButtonType: String {
    case ok = "OK"
    case cancel = "CANCEL"
    case yes = "YES"
    case no = "NO"
}

class PopupViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: PrimaryButton!
    
    override func setup() {
        super.setup()
    }

}
