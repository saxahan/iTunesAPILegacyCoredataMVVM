//
//  MediaService.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum MediaService: ServiceDefinable {
    case searchItunes(term: String, entity: MediaType)
}

extension MediaService {
    var baseURL: URL {
        return AppConfig.baseURL.appendingPathComponent("search")
    }

    var method: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .searchItunes(let term, let entity):
            return .requestParameters(parameters: ["term": term, "entity": entity.rawValue])
//        default:
//            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return Request.baseHeaders
    }
}
