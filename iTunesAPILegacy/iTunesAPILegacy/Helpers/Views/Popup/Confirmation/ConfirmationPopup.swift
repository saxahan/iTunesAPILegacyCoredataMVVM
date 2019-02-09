//
//  ConfirmationPopup.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class ConfirmationPopup: Popup {
    
    @IBOutlet weak var contentView: UIView!

    // top stack view vertical
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    // top stack view vertical
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var yesButton: HoldableButton!
    @IBOutlet weak var noButton: HoldableButton!

    // images
    var topImage: UIImage?

    // text
    var textTitle: String?
    var textMessage: String?

    class func create(title: String?, message: String? = nil, topImage: UIImage? = nil, completion: PopupCompletionState? = nil) -> ConfirmationPopup {
        let popup = ConfirmationPopup.initFromNib()
        popup.topImage = topImage
        popup.textTitle = title
        popup.textMessage = message
        popup.stateBlock = completion
        popup.shouldDismissTouchOutside = false
        return popup
    }

    override func setup() {
        super.setup()
        initItems()
    }

    private func initItems() {
        if let topImage = topImage {
            topImageView?.image = topImage
        }

        titleLabel?.text = textTitle
        messageLabel?.text = textMessage
    }

    // MARK: Actions

    @IBAction func yesTapped(_ sender: Any) {
        dismiss { [weak self] in
            self?.stateBlock?(.yes)
        }
    }

    @IBAction func noTapped(_ sender: Any) {
        debugPrint(#function)
        dismiss { [weak self] in
            self?.stateBlock?(.no)
        }
    }

}
