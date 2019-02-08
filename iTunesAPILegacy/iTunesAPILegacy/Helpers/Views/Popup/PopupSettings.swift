//
//  PopupSettings.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum PopupType: String {
    case info
    case warning
    case error
    case success
}

enum PopupButtonType: String {
    case ok
    case cancel
    case yes
    case no
    case select
    case dismiss
}

typealias PopupCompletionState = (_ state: PopupButtonType) -> Void
typealias PopupCompletion<T> = (_ data: T?) -> Void

