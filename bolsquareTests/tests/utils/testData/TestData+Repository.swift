//
//  TestData+Repository.swift
//  bolsquareTests
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

@testable import bolsquare

enum SampleRepository {
    case filled
    case withoutDescription
    case empty

    var id: Int {
        switch self {
        case .filled: 1
        case .withoutDescription: 2
        case .empty: 3
        }
    }

    var name: String {
        switch self {
        case .filled: "Repo 1"
        case .withoutDescription: "Repo 2"
        case .empty: ""
        }
    }

    var description: String? {
        switch self {
        case .filled: "Description 1"
        case .withoutDescription: nil
        case .empty: nil
        }
    }

    var stargazersCount: Int {
        switch self {
        case .filled, .withoutDescription:
            100
        case .empty:
            .zero
        }
    }

    var language: String? {
        switch self {
        case .filled: "swift"
        case .withoutDescription: "kotlin"
        case .empty: nil
        }
    }

    var owner: Repository.Owner? {
        switch self {
        case .filled, .withoutDescription:
            Repository.Owner(login: "login123", avatarURL: "https://exmple.com/avatar.png")
        case .empty:
            nil
        }
    }

    var repository: Repository {
        Repository(
            id: id,
            name: name,
            description: description,
            stargazersCount: stargazersCount,
            language: language,
            owner: owner
        )
    }
}
