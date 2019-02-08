//
//  UIView+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIView {
    private static func instanceFromNib<T: UIView>(name: String? = nil) -> T {
        return Bundle.main.loadNibNamed(name ?? String(describing: self), owner: nil, options: nil)?.first as! T
    }

    static func initFromNib(name: String? = nil) -> Self {
        return instanceFromNib(name: name)
    }

    func roundCorners(_ corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: CGFloat = 15) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }


    class func createButton(frame btnFrame: CGRect = .zero, imageName: String, alwaysTemplate: Bool = false, title: String? = nil, target: Any?, action: Selector) -> UIButton {
        let btn = UIButton(frame: btnFrame)
        btn.setImage(UIImage(named: imageName)?.withRenderingMode(alwaysTemplate ? .alwaysTemplate : .alwaysOriginal), for: .normal)
        btn.addTarget(target, action: action, for: .touchUpInside)

        if let title = title {
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.titleLabel?.font = Constants.Font.primaryButton
            btn.setTitleColor(.white, for: .normal)
            btn.setTitle(title, for: .normal)
            btn.semanticContentAttribute = .forceRightToLeft
            btn.imageEdgeInsets = UIEdgeInsets(top: btn.imageEdgeInsets.top, left: 10, bottom: btn.imageEdgeInsets.bottom, right: -10)
        }

        return btn
    }

    func dismissKeyboardOnTapOutside(cancelsTouchesInView: Bool = true) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = cancelsTouchesInView
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}

// MARK: Inspectable

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue

            if self.isKind(of: UIImageView.self) {
                layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
