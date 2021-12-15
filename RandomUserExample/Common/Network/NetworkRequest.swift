//
//  Requests.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Foundation

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

extension URLRequest {
    init(
        rawUrl: String,
        method: NetworkMethod,
        params: [String: Any]? = nil,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeout: TimeInterval = 30
    ) {
        guard var url = URL(string: rawUrl) else {
            preconditionFailure("rawUrl is a not valid URL")
        }
        if let params = params, var components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            components.queryItems = params.map { (key, value) in
                URLQueryItem(name: key, value: String(describing: value))
            }
            if let newUrl = components.url {
                url = newUrl
            } else {
                NSLog("[WARN] params are invalid")
            }

        } else {
            NSLog("[WARN] params are invalid")
        }
        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        self.httpMethod = method.rawValue
    }

    mutating func with(body: Data?) -> Self {
        self.httpBody = body
        return self
    }

    mutating func with<T: Encodable>(body: T?) -> Self {
        if let body = body {
            self.httpBody = safety { try JSONEncoder().encode(body) }
        }
        return self
    }
}
