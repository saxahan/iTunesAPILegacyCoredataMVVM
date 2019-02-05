//
//  APIProvider.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

// MARK: typealias blocks

typealias Completion = (_ result: Result<Response, Error>) -> Void

// MARK: Exception

enum APIProviderException: Swift.Error {
    case wrongBaseUrlDefined
    case cannotCreateRequestUrl
}

extension APIProviderException {
    var localizedDescription: String {
        switch self {
        case .wrongBaseUrlDefined:
            return "API base url is not correct."
        case .cannotCreateRequestUrl:
            return "Can not be created request url while getting from url components."
        }
    }
}

// MARK: Provider

protocol APIProviderType: AnyObject {
    associatedtype Service: ServiceType

    func request(_ service: Service, completion: @escaping Completion)
}

class APIProvider<Service: ServiceType>: APIProviderType {
    let timeout: Double = 60.0

    func request(_ service: Service, completion: @escaping Completion) {
        guard var components = URLComponents(url: service.baseURL, resolvingAgainstBaseURL: true) else {
            completion(Result<Response, Error>.failure(APIProviderException.wrongBaseUrlDefined))
            return
        }

        var httpBody: Data?
        switch service.task {
        case .requestPlain:
            break
        case .requestData(let data):
            httpBody = data
        case .requestParameters(let parameters):
            components.queryItems = parameters.map {
                return URLQueryItem(name: $0.key, value: "\($0.value as? String ?? "")")
            }
        }

        guard let requestUrl = components.url else {
            completion(Result<Response, Error>.failure(APIProviderException.cannotCreateRequestUrl))
            return
        }

        var request = URLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        request.allHTTPHeaderFields = service.headers
        request.httpMethod = service.method.rawValue
        request.httpBody = httpBody

        debugPrint(request)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
                // FIXME: in order to indicate right type of error, at least we must know web service status codes, or error messages etc...
//                var apiErr: APIError = .unknown
//                switch response.statusCode {
//                case 500:
//                    apiErr = .serverError
//                    break
//
//                default:
//                    break
//                }
                debugPrint(error?.localizedDescription ?? "")
                let err = error ?? APIError.unknown
                completion(Result<Response, Error>.failure(err))
                return
            }

            let resp = (Response(statusCode: response.statusCode, data: data, request: request, response: response))
            debugPrint(resp)
            completion(Result<Response, Error>.success(resp))
        }

        task.resume()
    }

}
