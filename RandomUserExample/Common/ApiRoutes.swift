//
//  Requests.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Foundation

struct ApiRoute<T: Decodable> {
    let request: URLRequest
}

extension ApiRoute {
    static func getUsers(page: Int, size: Int, usersSeed: String) -> ApiRoute<UsersResponse> {
        ApiRoute<UsersResponse>(
            request: URLRequest(
                rawUrl: "https://randomuser.me/api/",
                method: .get,
                params: [
                    "page": page,
                    "results": size,
                    "seed": usersSeed
                ]
            )
        )
    }
}
