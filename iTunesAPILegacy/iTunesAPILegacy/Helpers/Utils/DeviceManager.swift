//
//  DeviceManager.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class DeviceManager {

    static let shared = DeviceManager()

    private let currentDevice: UIDevice = UIDevice.current

    func isPad() -> Bool {
        return currentDevice.userInterfaceIdiom == .pad
    }

    func isPhone() -> Bool {
        return currentDevice.userInterfaceIdiom == .phone
    }

    func isLandscape() -> Bool {
        return currentDevice.orientation.isLandscape
    }

    func isPortrait() -> Bool {
        return currentDevice.orientation.isPortrait
    }
}
