//
//  APIProvider.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

// MARK: typealias blocks

internal typealias Completion = (_ result: Result<Response, APIError>) -> Void

// MARK: Provider

protocol APIProviderType: AnyObject {
    associatedtype Service: ServiceType

    func request(_ service: Service, completion: @escaping Completion)
}

class APIProvider<Service: ServiceType>: APIProviderType {
    let timeout: Double = 60.0

    func request(_ service: Service, completion: @escaping Completion) {
        guard var components = URLComponents(url: service.baseURL, resolvingAgainstBaseURL: true) else {
            completion(Result<Response, APIError>.failure(APIError.wrongBaseUrlDefined))
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
            completion(Result<Response, APIError>.failure(APIError.cannotCreateRequestUrl))
            return
        }

        var request = URLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        request.allHTTPHeaderFields = service.headers
        request.httpMethod = service.method.rawValue
        request.httpBody = httpBody

        debugPrint(request)

        URLSession.shared.dataTask(with: request) { [unowned self] data, response, error in
            if let hasError = error {
                completion(Result<Response, APIError>.failure(.unknown(hasError)))
                return
            }

            if let respon = response as? HTTPURLResponse, respon.statusCode == -1009 {
                // timeout error
                completion(Result<Response, APIError>.failure(.timeout))
                return
            }
            
            guard let dat = data else {
                completion(Result<Response, APIError>.failure(.missingData))
                return
            }

            guard let respon = response as? HTTPURLResponse,
                self.isSuccessCode(respon.statusCode), error == nil else {

                    if let err = error {
                        completion(Result<Response, APIError>.failure(.unknown(err)))
                        return
                    }

                    do {
                        let errResponse = try JSONSerialization.jsonObject(with: dat, options: .allowFragments) as? [String: AnyObject]
                        let errMsg = errResponse?["errorMessage"] as? String ?? ""
                        completion(Result<Response, APIError>.failure(APIError.errorMessageFromBackend(errMsg)))
                        debugPrint(errMsg)
                        return
                    } catch let errr {
                        debugPrint(errr)
                        completion(Result<Response, APIError>.failure(.unknown(errr)))
                        return
                    }
            }

            let resp = (Response(statusCode: respon.statusCode, data: dat, request: request, response: respon))
            debugPrint(resp)
            completion(Result<Response, APIError>.success(resp))

        }.resume()
    }

    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }

    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }

}
