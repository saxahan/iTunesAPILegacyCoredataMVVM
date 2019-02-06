//
//  MediaService.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum MediaService: HttpServiceDefinable {
    case searchItunes(term: String, entity: MediaType, limit: Int)
}

extension MediaService {
    var baseURL: URL {
        return AppConfig.baseURL.appendingPathComponent("search")
    }

    var method: HttpMethod {
        return .get
    }

    var task: HttpTask {
        switch self {
        case .searchItunes(let term, let entity, let limit):
            return .requestParameters(parameters: ["term": term,
                                                   "entity": entity.rawValue,
                                                   "limit": "\(limit)"
                ])
//        default:
//            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return Request.baseHeaders
    }
}
