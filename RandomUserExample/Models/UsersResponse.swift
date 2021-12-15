//
//  UsersResponse.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let results: [UserModel]
    let info: UsersInfo
}

extension UsersResponse {
    static var empty: UsersResponse {
        UsersResponse(results: [], info: UsersInfo(seed: "", results: 0, page: 1, version: ""))
    }
}

// MARK: - UsersInfo
struct UsersInfo: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

// MARK: - UserModel
struct UserModel: Codable {
    let gender: UserGender
    let name: UserName
    let location: UserLocation
    let email: String
    let login: UserLogin
    let dob: UserDob
    let registered: UserDob
    let phone: String
    let cell: String
    let id: UserID
    let picture: UserPicture
    let nat: String
}

extension UserModel: Hashable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.login.uuid == rhs.login.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.name)
        hasher.combine(id.value)
    }
}

// MARK: - UserDob
struct UserDob: Codable {
    let date: String
    let age: Int

    var formattedDate: String {
        let inFormatter = DateFormatter()
        inFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let outFormatter = DateFormatter()
        outFormatter.dateFormat = "MMM d, yyyy"
        guard let _date = inFormatter.date(from: date) else {
            return date
        }
        return outFormatter.string(from: _date)
    }
}

// MARK: - UserGender
enum UserGender: String, Codable {
    case female = "female"
    case male = "male"
}

// MARK: - UserID
struct UserID: Codable {
    let name: String
    let value: String?
}

// MARK: - UserLocation
struct UserLocation: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: String
    let coordinates: Coordinates
    let timezone: Timezone

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(Street.self, forKey: .street)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
        if let postcode = try? container.decode(Int.self, forKey: .postcode) {
            self.postcode = postcode.description
        } else {
            self.postcode = try container.decode(String.self, forKey: .postcode)
        }
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.timezone = try container.decode(Timezone.self, forKey: .timezone)
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset: String
    let description: String
}

// MARK: - Login
struct UserLogin: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

// MARK: - Name
struct UserName: Codable {
    let title: String
    let first: String
    let last: String

    var fullName: String {
        "\(first) \(last)"
    }
}

// MARK: - Picture
struct UserPicture: Codable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}
