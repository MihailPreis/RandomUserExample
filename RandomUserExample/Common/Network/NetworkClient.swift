//
//  NetworkClient.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Combine
import Foundation

final class NetworkClient {
    private static let validCodes: Range<Int> = 200..<300

    static let shared = NetworkClient()

    struct Response<T> {
        let result: Result<T, ErrorResponse>
        let response: URLResponse
    }

    func run<T: Decodable>(_ route: ApiRoute<T>) -> AnyPublisher<Response<T>, Error> {
        logDebug("Request started\n" + route.request.asCURL)
        return URLSession.shared
            .dataTaskPublisher(for: route.request)
            .tryMap { item -> Response<T> in
                logDebug("""
                Request finished
                Status code: \((item.response as? HTTPURLResponse)?.statusCode.description ?? "-")
                Pretty data: \(String(data: item.data, encoding: .utf8) ?? "none")
                """)
                let result: Result<T, ErrorResponse>
                if let response = item.response as? HTTPURLResponse, !NetworkClient.validCodes.contains(response.statusCode) {
                    let model = try JSONDecoder().decode(ErrorResponse.self, from: item.data)
                    result = .failure(model)
                } else {
                    let model = try JSONDecoder().decode(T.self, from: item.data)
                    result = .success(model)
                }
                return Response(result: result, response: item.response)
            }
            .mapError { err in
                logError(err)
                return err
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func cancelAllRequests() {
        URLSession.shared.invalidateAndCancel()
    }
}
