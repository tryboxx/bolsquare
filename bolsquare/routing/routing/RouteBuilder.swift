//
//  RouteBuilder.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

protocol RouteBuilder: AutoFactory {
    func findRoute(forUrl url: URL) -> Route?
}

struct RouteBuilderImpl: RouteBuilder {

    func findRoute(forUrl url: URL) -> Route? {
        routes.reduce(nil) { accum, templateAndRoute in
            let (template, route) = templateAndRoute
            return accum ?? parseRouteParams(url: url, fromTemplate: template).flatMap(route)
        }
    }

    static func getAllRoutes() -> [String] {
        routes.keys.map {
            $0
        }
    }

    // Match path to template and parse parameters
    // Template: /path/with/:param1/and/param2
    // Path: /path/with/parameter1/and/parameter2
    // RouteParams: [param1: parameter1, param2: parameter2]
    private func parseRouteParams(url: URL, fromTemplate template: String) -> RouteParams? {

        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let scheme = urlComponents?.scheme ?? url.scheme
        let host = urlComponents?.host ?? url.host
        let path = urlComponents?.path ?? url.path

        var pathComponents = path
            .components(separatedBy: "/")
            .filter { $0.isEmpty == false && !$0.hasPrefix("?") }

        let templateComponents = template
            .components(separatedBy: "/")
            .filter { $0.isEmpty == false }

        guard templateComponents.count == pathComponents.count else { return nil }

        var params: RouteParams = [:]

        for (templateComponent, pathComponents) in zip(templateComponents, pathComponents) {
            if templateComponent.hasPrefix(":") {
                // matched a token
                let paramName = String(templateComponent.dropFirst())
                params[paramName] = pathComponents
            } else if templateComponent != pathComponents {
                return nil
            }
        }

        urlComponents?
            .queryItems?
            .forEach { item in
                params[item.name] = item.value
            }

        return params
    }
}

// Dictionary of all available routes paths.
// Dictionary value is a method that parses path parameters and create Route from them.
private let routes: [String: (RouteParams) -> Route?] = [

    "/repositoryList": repositoryList
]

private func repositoryList(_: RouteParams) -> Route {
    .tab(.repositoryList)
}
