//
//  PrimaryButton.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

@IBDesignable
class PrimaryButton: HoldableButton {
    
    required init(title: String, image: UIImage? = nil) {
        super.init(frame: .zero)

        backgroundColor = Constants.Color.primary
        titleLabel?.textAlignment = .center
        titleLabel?.font = Constants.Font.primaryButton.withSize(24)
        setTitleColor(.white, for: .normal)
        tintColor = .white
        setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)

        if image != nil {
            setTitle("  \(title)", for: .normal)
        }
        else {
            setTitle(title, for: .normal)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }

}
