//
//  Route.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

enum Route: Equatable {
    case tab(Route.Tab)

    enum Tab: Equatable {
        case repositoryList
    }

    init?(url: URL, builder: RouteBuilder = RouteBuilderImpl()) {
        guard let route = builder.findRoute(forUrl: url) else { return nil }
        self = route
    }

    var requirements: [RouteRequirement] {
        []
    }
}

// MARK: Tab Route Helpers {
extension Route {

    var tabRoute: Route.Tab? {
        switch self {
        case .tab(let route): return route
        default: return nil
        }
    }
}

enum RouteRequirement: Equatable, CaseIterable {
    case needsFreshPolicies
    case needsFreshHomes
}
