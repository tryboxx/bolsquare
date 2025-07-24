//
//  RepositoryListCoordinator.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit
import InjectGrail
import InjectGrailMacros

protocol RepositoryListCoordinatorInjector {
    var factory: Factory { get }
}

protocol RepositoryListCoordinator: Coordinator, AutoMockable {}

@NeedsInjector
@Injects<RepositoryListViewModel>
final class RepositoryListCoordinatorImpl: CoordinatorImpl, RepositoryListCoordinator {

    override var viewController: ViewController {
        repositoryListViewController
    }

    private lazy var repositoryListViewModel: RepositoryListViewModel = setupViewModel()
    private lazy var repositoryListViewController = RepositoryListViewController(viewModel: repositoryListViewModel)

    // MARK: - Lifecycle

    init(injector: RepositoryListCoordinatorInjectorImpl) {
        self.injector = injector
    }

    // MARK: - Private
    private func setupViewModel() -> RepositoryListViewModel {
        let viewModel = factory.repositoryListViewModel(injector: inject())

        return viewModel
    }
}
