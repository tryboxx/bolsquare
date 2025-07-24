//
//  MainCoordinator.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit
import InjectGrail
import InjectGrailMacros

protocol MainCoordinatorInjector {
    var factory: Factory { get }
    var routingController: RoutingController { get }
    var mainScreenContext: MainScreenContext { get }
}

protocol MainCoordinator: Coordinator, Routable, AutoMockable {}

@NeedsInjector
@Injects<
    RepositoryListCoordinator
>
final class MainCoordinatorImpl: CoordinatorImpl, MainCoordinator {

    private lazy var repositoryListCoordinator: RepositoryListCoordinator = self.createRepositoryListCoordinator()

    required init(injector: MainCoordinatorInjectorImpl) {
        self.injector = injector

        super.init()

        handleContextDestination(mainScreenContext)
    }

    private func handleContextDestination(_ context: MainScreenContext) {
        // Add impl
    }

    private func createRepositoryListCoordinator() -> RepositoryListCoordinator {
        let coordinator = factory.repositoryListCoordinator(injector: inject())

        return coordinator
    }
}

extension MainCoordinatorImpl: Routable {

    func handleRoute(_ route: Route, navigationStack: [UIViewController] = [], animated: Bool) async -> Bool {
        true
    }
}
