//
//  Repository.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import Foundation

// swiftlint:disable nesting
struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let language: String?
    let owner: Owner?

    struct Owner: Decodable {
        let login: String
        let avatarURL: String

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case language
        case owner
        case stargazersCount = "stargazers_count"
    }
}
