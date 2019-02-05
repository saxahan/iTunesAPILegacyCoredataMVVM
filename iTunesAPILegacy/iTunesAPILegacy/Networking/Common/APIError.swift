//
//  APIError.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum APIError: Swift.Error {
    case unknown
    case invalidSearchTerm
    case invalidURL
    case invalidServerResponse
    case serverError(Int)
    case missingData
    case invalidJSON(Swift.Error)
    case jsonMapping
    case objectMapping(Swift.Error)
    case errorMessageFromBackend(String)
}

extension APIError {
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "ERROR_UNKNOWN".localized
        case .invalidSearchTerm:
            return "ERROR_INVALID_SEARCH_TERM".localized
        case .invalidURL:
            return "ERROR_INVALID_URL".localized
        case .invalidServerResponse:
            return "ERROR_INVALID_SERVER_RESPONSE".localized
        case .serverError(let statusCode):
            return String(format: "ERROR_SERVER_WITH_STATUS_CODE".localized, statusCode)
        case .missingData:
            return "ERROR_MISSING_DATA".localized
        case .invalidJSON(let err):
            return String(format: "ERROR_INVALID_JSON_WITH_DESC".localized, err.localizedDescription)
        case .jsonMapping:
            return "ERROR_MAP_JSON".localized
        case .objectMapping(_):
            return "ERROR_MAP_OBJECT".localized
        case .errorMessageFromBackend(let errorMessage):
            return errorMessage
        }
    }
}
