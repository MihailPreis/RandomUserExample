//
//  URLRequest.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Foundation

extension URLRequest {
    var asCURL: String {
        guard let url = url else {
            return ""
        }

        var result = "curl \(url.absoluteString)"

        if httpMethod == "HEAD" {
            result += " --head"
        }

        if let method = httpMethod, !["HEAD", "GET"].contains(method) {
            result += "\n\t-X \(method)"
        }

        allHTTPHeaderFields?
            .filter { $0.key != "Cookie" }
            .forEach { result += "\n\t-H '\($0.key): \($0.value)'" }

        httpBody
            .flatMap { String(data: $0, encoding: .utf8) }
            .flatMap { result += "\n\t-d '\($0)'" }

        return result
    }
}
