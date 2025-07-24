// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import UIKit

//Extension of RootInject which contains definition of `inject` functions creating all other Injectors.
extension AppRootInjector {

    func inject(mainScreenContext: MainScreenContext) -> MainCoordinatorInjectorImpl {
      return MainCoordinatorInjectorImpl(
        factory: factory,
      routingController: routingController,
      mainScreenContext: mainScreenContext,
      networkService: networkService
      )
    }
    
    func inject() -> MainRouterInjectorImpl {
      return MainRouterInjectorImpl(
        factory: factory,
      routingController: routingController,
      networkService: networkService
      )
    }
    
    func inject() -> RepositoryListCoordinatorInjectorImpl {
      return RepositoryListCoordinatorInjectorImpl(
        factory: factory,
      networkService: networkService
      )
    }
    
    func inject() -> RepositoryListViewModelInjectorImpl {
      return RepositoryListViewModelInjectorImpl(
        factory: factory,
      networkService: networkService
      )
    }
    
}
