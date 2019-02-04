//
//  ServiceDefinable.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String: Any]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    // etc...
}

enum HTTPTask {
    case requestPlain
    case requestData(Data)
    case requestParameters(parameters: HTTPParameters)
    // etc...
}

internal protocol ServiceType {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: [String: String]? { get }
}

protocol ServiceDefinable: ServiceType {

}
