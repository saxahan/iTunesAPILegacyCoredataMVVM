//
//  API.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

final class API {
    // * For testing purposes, providers are defined as statics
    // * Not recommended
    // ** We should keep local variables in each view models for provider instead.

    static let mediaProvider: APIProvider<MediaService> = {
        return APIProvider<MediaService>()
    }()
}
