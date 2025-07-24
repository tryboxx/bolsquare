//
//  Routable.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

typealias RoutableCoordinator = Routable & Coordinator

@MainActor
protocol Routable {

    // Returns yes once the proper coordinator/view is on screen and handling can start.
    func isReadyToHandleRoutes() -> Bool

    // This method only check if given coordinator is capable of handling such route.
    // It does not check if it has the proper data to handle it.
    func canHandleRoute(_ route: Route) -> Bool

    // Actually handles the route through all coordinators.
    func handleRoute(_ route: Route, navigationStack: [UIViewController], animated: Bool) async -> Bool
}

extension Routable where Self: Coordinator {
    func handleRoute(
        _ route: Route,
        navigationStack: [UIViewController],
        on coordinator: Coordinator?,
        animated: Bool
    ) async -> Bool {

        if let coordinator = coordinator as? RoutableCoordinator,
           coordinator.canHandleRoute(route) {
            let controllers = [coordinator.rootViewController].compactMap { $0 }
            return await coordinator.handleRoute(
                route,
                navigationStack: navigationStack + controllers,
                animated: animated
            )
        } else if let coordinator {
            let controllers = [coordinator.rootViewController].compactMap { $0 }
            navigationController?.setViewControllers(
                navigationStack + controllers,
                animated: animated
            )
        } else {
            if !navigationStack.isEmpty {
                navigationController?.setViewControllers(
                    navigationStack,
                    animated: animated
                )
            }
        }

        return true
    }
}

extension Routable {
    func isReadyToHandleRoutes() -> Bool {
        true
    }

    func canHandleRoute(_ route: Route) -> Bool {
        false
    }
}
