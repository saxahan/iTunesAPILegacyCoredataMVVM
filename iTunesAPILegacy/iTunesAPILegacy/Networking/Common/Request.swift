//
//  Request.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

struct Request {
    static var baseHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept-Language": DeviceManager.shared.language
        ]
    }
}
