//
//  SettingsService.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum SettingsService: HttpServiceDefinable {

}

extension SettingsService {
    var baseURL: URL {
        return AppConfig.baseURL
    }

    var method: HttpMethod {
        return .get
    }

    var task: HttpTask {
        return .requestPlain
    }

    var headers: [String : String]? {
        return nil
    }
}
