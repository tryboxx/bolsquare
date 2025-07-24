//
//  MainRouter.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit
import InjectGrail
import InjectGrailMacros

enum MainScreenContext: Equatable {
    case none
}

protocol MainRouterInjector {
    var factory: Factory { get }
    var routingController: RoutingController { get }
    var networkService: NetworkService { get }
}

@MainActor
@NeedsInjector
@Injects<
    MainCoordinator
>
final class MainRouter {
    let routingViewController: MainRoutingViewController
    private var children = [Coordinator]()
    private var mainCoordinator: MainCoordinator?

    required init(injector: MainRouterInjectorImpl) {
        self.injector = injector
        self.routingViewController = injector.factory.mainRoutingViewController()
    }

    func start() {
        selectFirstCoordinator()
    }

    @objc private func restart() {
        clearMainCoordinator()
        selectFirstCoordinator()
    }

    private func selectFirstCoordinator() {
        showRepositoryListScreen()
    }

    private func clearMainCoordinator() {
        guard let mainCoordinator else { return }
        removeCoordinator(coordinator: mainCoordinator)
        self.mainCoordinator = nil
    }

    private func resetMainCoordinator(
        context: MainScreenContext
    ) -> MainCoordinator {
        let coordinator = createMainCoordinator(context: context)
        mainCoordinator = coordinator
        return coordinator
    }

    private func createMainCoordinator(
        context: MainScreenContext
    ) -> MainCoordinator {
        factory.mainCoordinator(
            injector: inject(
                mainScreenContext: context
            )
        )
    }
}

extension MainRouter {

    private func showRepositoryListScreen() {
        let repositoryListCoordinator = factory.repositoryListCoordinator(injector: makeRepositoryListCoordinatorInjector())
        changeActiveCoordinator(to: repositoryListCoordinator)
    }

    private func makeRepositoryListCoordinatorInjector() -> RepositoryListCoordinatorInjectorImpl {
        RepositoryListCoordinatorInjectorImpl(factory: factory, networkService: networkService)
    }
}

extension MainRouter {
    private func changeActiveCoordinator(to coordinator: Coordinator) {
        CoordinatorImpl.rootModalCoordinator = nil
        children.removeAll()
        children.append(coordinator)
        routingViewController.show(viewController: coordinator.viewController)

        routingController.activeCoordinatorChanged()
    }

    private func removeCoordinator(coordinator: Coordinator) {
        guard let index = (children.firstIndex { $0 === coordinator }) else { return  }
        children.remove(at: index)
    }
}

extension MainRouter: Routable {
    func isReadyToHandleRoutes() -> Bool {
        mainCoordinator != nil && isMainCoordinatorActive()
    }

    func canHandleRoute(_ route: Route) -> Bool {
        true
    }

    func handleRoute(_ route: Route, navigationStack: [UIViewController] = [], animated: Bool) async -> Bool {
        guard isReadyToHandleRoutes() else { return false }

        return await mainCoordinator?.handleRoute(route, navigationStack: navigationStack, animated: animated) ?? false
    }
}

extension MainRouter {
    private func isMainCoordinatorActive() -> Bool {
        (children.last as? MainCoordinator) != nil
    }
}
