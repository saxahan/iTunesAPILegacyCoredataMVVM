//
//  PopupSettings.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

typealias PopupCompletionState = (_ state: PopupStates) -> Void
typealias PopupCompletion<T> = (_ data: T?) -> Void

enum PopupStates: String {
    case ok
    case cancel
    case yes
    case no
    case select
    case dismiss
}

struct PopupAnimationProps {

    struct Color {
       static let backViewColor: UIColor = UIColor(white: 0.1, alpha: 0.5)
    }

    struct Show {
        static let duration: TimeInterval = 0.5
        static let delay: TimeInterval = 0.0
        static let springWithDamping: CGFloat = 0.5
        static let springVelocity: CGFloat = 10.0
    }

    struct Dismiss {
        static let duration: TimeInterval = 0.2
        static let delay: TimeInterval = 0.0
    }
}

