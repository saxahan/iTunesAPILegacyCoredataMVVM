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
}

extension APIError {
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidSearchTerm:
            return "Invalid search term"
        case .invalidURL:
            return "Invalid url"
        case .invalidServerResponse:
            return "Invalid server response"
        case .serverError(_):
            return "Server error"
        case .missingData:
            return "Missing data"
        case .invalidJSON(_):
            return "Invalid json"
        case .jsonMapping:
            return "Failed mapping to json"
        case .objectMapping(_):
            return "Failed mapping to object"
        }
    }
}
