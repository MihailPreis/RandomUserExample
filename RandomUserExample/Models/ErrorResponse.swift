//
//  ErrorResponse.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Foundation

// MARK: - ErrorResponse
struct ErrorResponse: Codable, Error, LocalizedError {
    let error: String

    var errorDescription: String? { error }
}
