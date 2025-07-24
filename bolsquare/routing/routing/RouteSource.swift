//
//  RouteSource.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

enum RouteSource: Equatable {
    case applicationOpenUrl(String)
    case applicationContinue(NSUserActivity)
    case mainRouter

    var name: String {
        switch self {
        case .applicationOpenUrl: return "applicationOpenUrl"
        case .applicationContinue: return "applicationContinue"
        case .mainRouter: return "mainRouter"
        }
    }

    var properties: [String: Any]? {
        switch self {
        case .applicationOpenUrl(let urlString): return ["sourceUrl": urlString]
        case .applicationContinue(let activity): return [
            "activityType": activity.activityType,
            "webpageURL": activity.webpageURL ?? "-",
            "referrerURL": activity.referrerURL ?? "-"
        ]
        case .mainRouter: return nil
        }
    }

    var nameWithProperties: [String: Any] {
        [:]
    }
}
