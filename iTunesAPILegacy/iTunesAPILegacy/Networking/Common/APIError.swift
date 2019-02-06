//
//  APIError.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum APIError: Swift.Error {
    case unknown(Swift.Error)
    case timeout
    case invalidSearchTerm
    case invalidURL
    case invalidServerResponse
    case serverError(Int)
    case missingData
    case invalidJSON(Swift.Error)
    case jsonMapping
    case objectMapping(Swift.Error)
    case errorMessageFromBackend(String)
    case wrongBaseUrlDefined
    case cannotCreateRequestUrl
}

extension APIError {
    var localizedDescription: String {
        switch self {
        case .timeout:
            return "ERROR_TIMEOUT".localized
        case .unknown(let err):
            return String(format: "ERROR_UNKNOWN_X".localized, err.localizedDescription)
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
        case .wrongBaseUrlDefined:
            return "EXCEPTION_WRONG_BASE_URL".localized
        case .cannotCreateRequestUrl:
            return "EXCEPTION_CANNOT_CREATE_REQUEST_URL".localized
        }
    }
}
