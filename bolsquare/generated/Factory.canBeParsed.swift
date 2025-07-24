// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT





@MainActor
protocol Factory: AutoMockable {
    func contentDataSource() -> ContentDataSource
    func mainCoordinator(injector: MainCoordinatorInjectorImpl) -> MainCoordinator
    func mainRoutingViewController() -> MainRoutingViewController
    func repositoryListCoordinator(injector: RepositoryListCoordinatorInjectorImpl) -> RepositoryListCoordinator
    func repositoryListViewModel(injector: RepositoryListViewModelInjectorImpl) -> RepositoryListViewModel
    func routeBuilder() -> RouteBuilder
}

struct FactoryImpl: Factory {
    func contentDataSource() -> ContentDataSource {
        return ContentDataSourceImpl()
    }
    func mainCoordinator(injector: MainCoordinatorInjectorImpl) -> MainCoordinator {
        return MainCoordinatorImpl(injector: injector)
    }
    func mainRoutingViewController() -> MainRoutingViewController {
        return MainRoutingViewControllerImpl()
    }
    func repositoryListCoordinator(injector: RepositoryListCoordinatorInjectorImpl) -> RepositoryListCoordinator {
        return RepositoryListCoordinatorImpl(injector: injector)
    }
    func repositoryListViewModel(injector: RepositoryListViewModelInjectorImpl) -> RepositoryListViewModel {
        return RepositoryListViewModelImpl(injector: injector)
    }
    func routeBuilder() -> RouteBuilder {
        return RouteBuilderImpl()
    }
}