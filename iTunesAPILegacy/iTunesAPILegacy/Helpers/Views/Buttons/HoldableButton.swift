//
//  HoldableButton.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class HoldableButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.alpha = self.isHighlighted ? 0.75 : 1.0
            }
        }
    }

}
