//
//  RoutingController.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

protocol RoutingControllerEventResponder {
    func addObserver(_ observer: RoutingControllerEventObserver)
    func removeObserver(_ observerID: UUID)
}

protocol RoutingControllerEventObserver: AnyObject {
    var observerID: UUID { get }
    func routeDidFinish()
}

private struct RoutingControllerEventObserverWrapper {
    let observerID: UUID
    weak var observer: RoutingControllerEventObserver?

    init(observer: RoutingControllerEventObserver) {
        self.observerID = observer.observerID
        self.observer = observer
    }
}

@MainActor
protocol RoutingController: AutoMockable, RoutingControllerEventResponder {
    var mainRouter: MainRouter? { get set }

    var hasPendingRoute: Bool { get }
    var pendingRoute: Route? { get }
    var pendingRouteSource: RouteSource? { get }

    func canHandleUrl(_ url: URL) -> Bool
    func handleUrl(_ url: URL, source: RouteSource) -> Bool
    func handleRoute(_ route: Route, source: RouteSource)
    func didEnterBackground()
    func activeCoordinatorChanged()
    func handleCurrentRoute()
}

final class RoutingControllerImpl: RoutingController {

    let observerID = UUID()

    var mainRouter: MainRouter?

    var hasPendingRoute: Bool {
        route != nil
    }

    private var hasObservers: Bool { observers.isEmpty == false }
    private var observers: [RoutingControllerEventObserverWrapper] = []

    var pendingRoute: Route? { route }
    var pendingRouteSource: RouteSource? { routeSource }

    private var route: Route? {
        didSet {
            tryToHandleCurrentRoute()
        }
    }

    private var routeSource: RouteSource?

    // This flag indicates if policies were refreshed (no matter if success or fail) since app went out of background.
    // Some Routes needs to wait for a very latest content.
    private var policiesRefreshedInThisSession = false {
        didSet {
            guard policiesRefreshedInThisSession == true else { return }

            guard failedRequirements.contains(.needsFreshPolicies) else { return }

            // If route does not have such requirement, then we ignore this notification, as route is probably already in progress or waiting for other requirement.
            guard route?.requirements.contains(.needsFreshPolicies) ?? false else { return }

            tryToHandleCurrentRoute()
        }
    }

    // This flag indicates if homes were refreshed (no matter if success or fail) since app went out of background.
    // Some Routes needs to wait for a very latest content.
    private var homesRefreshedInThisSession = false {
        didSet {
            guard homesRefreshedInThisSession == true else { return }

            guard failedRequirements.contains(.needsFreshHomes) else { return }

            // If route does not have such requirement, then we ignore this notification, as route is probably already in progress or waiting for other requirement.
            guard route?.requirements.contains(.needsFreshHomes) ?? false else { return }

            tryToHandleCurrentRoute()
        }
    }

    private let allowedSchemes = [
        "http",
        "https"
    ]

    private var failedRequirements: Set<RouteRequirement> = []

    init() {}

    func canHandleUrl(_ url: URL) -> Bool {
        guard let scheme = url.scheme,
              allowedSchemes.contains(scheme) else { return false }

        if url.host == nil {
            return true
        }

        return false
    }

    func handleUrl(_ url: URL, source: RouteSource) -> Bool {
        guard let route = Route(url: url) else {
            return false
        }

        handleRoute(route, source: source)
        return true
    }

    func handleRoute(_ route: Route, source: RouteSource) {
        routeSource = source
        self.route = route
    }

    func didEnterBackground() {
        reset()
    }

    func activeCoordinatorChanged() {
        tryToHandleCurrentRoute()
    }

    func handleCurrentRoute() {
        tryToHandleCurrentRoute()
    }
}

extension RoutingControllerImpl {

    func addObserver(_ observer: RoutingControllerEventObserver) {
        observers.append(RoutingControllerEventObserverWrapper(observer: observer))
    }

    func removeObserver(_ observerID: UUID) {
        observers.removeAll { $0.observerID == observerID }
    }

    private func removeAllEmptyObservers() {
        observers.removeAll { $0.observer == nil }
    }
}

extension RoutingControllerImpl: RoutingControllerEventObserver {

    func routeDidFinish() {
        guard hasObservers else { return }
        observers.forEach { $0.observer?.routeDidFinish() }
        removeAllEmptyObservers()
    }
}

extension RoutingControllerImpl {

    private func reset() {

        policiesRefreshedInThisSession = false
        homesRefreshedInThisSession = false
        route = nil
        routeSource = nil
        removeAllEmptyObservers()
    }

    private func tryToHandleCurrentRoute() {
        guard let mainRouter,
              let route else {
            return
        }
        let routeSource = routeSource

        guard mainRouter.isReadyToHandleRoutes() else {
            return
        }

        guard mainRouter.canHandleRoute(route) else {
            return
        }

        failedRequirements = getRouteFailedRequirements(for: route)
        guard failedRequirements.isEmpty else {
            mainRouter.routingViewController.startLoading()
            return
        }

        Task {
            let routeHandled = await mainRouter.handleRoute(route, navigationStack: [], animated: AppUI.animationsEnabled)
            if routeHandled {
                routeFinished()
            }
        }
    }

    private func routeFinished() {
        route = nil
        routeSource = nil
        mainRouter?.routingViewController.stopLoading()
        routeDidFinish()
    }

    private func getRouteFailedRequirements(for route: Route) -> Set<RouteRequirement> {
        var result = Set<RouteRequirement>()
        if route.requirements.contains(.needsFreshPolicies), policiesRefreshedInThisSession == false {
            result.insert(.needsFreshPolicies)
        }

        if route.requirements.contains(.needsFreshHomes), homesRefreshedInThisSession == false {
            result.insert(.needsFreshHomes)
        }

        return result
    }
}
