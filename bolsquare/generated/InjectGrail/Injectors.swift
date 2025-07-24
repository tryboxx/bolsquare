// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import UIKit

//MARK: - MainCoordinatorInjector
//Actual implementation of MainCoordinatorInjector which includes all dependencies found in RootInjector and required by this injector's children.
struct MainCoordinatorInjectorImpl: MainCoordinatorInjector {
  

  let factory: Factory
  let routingController: RoutingController
  let mainScreenContext: MainScreenContext
  let networkService: NetworkService
}

//MARK: - MainRouterInjector
//Actual implementation of MainRouterInjector which includes all dependencies found in RootInjector and required by this injector's children.
struct MainRouterInjectorImpl: MainRouterInjector {
  

  let factory: Factory
  let routingController: RoutingController
  let networkService: NetworkService
}

//MARK: - RepositoryListCoordinatorInjector
//Actual implementation of RepositoryListCoordinatorInjector which includes all dependencies found in RootInjector and required by this injector's children.
struct RepositoryListCoordinatorInjectorImpl: RepositoryListCoordinatorInjector {
  

  let factory: Factory
  let networkService: NetworkService
}

//MARK: - RepositoryListViewModelInjector
//Actual implementation of RepositoryListViewModelInjector which includes all dependencies found in RootInjector and required by this injector's children.
struct RepositoryListViewModelInjectorImpl: RepositoryListViewModelInjector {
  

  let factory: Factory
  let networkService: NetworkService
}
